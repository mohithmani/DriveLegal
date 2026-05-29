import { useEffect, useState, useRef } from "react";
import axios from "axios";

/* ================= CLEAN AI OUTPUT ================= */
const cleanAI = (text = "") =>
  text
    .replace(/[^\u0000-\u007F\u0B80-\u0BFF\u0900-\u097F₹•.,:()\-\s]/g, "")
    .replace(/\s+/g, " ")
    .trim();

/* ================= FORMAT TO POINTS ================= */
const formatAI = (text = "") =>
  text
    .split(".")
    .filter(Boolean)
    .map((t) => "• " + t.trim())
    .join("\n");

export default function ViolationsPage() {
  const [data, setData] = useState([]);
  const [filtered, setFiltered] = useState([]);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");
  const [search, setSearch] = useState("");
  const [stateFilter, setStateFilter] = useState("ALL");
  const [location, setLocation] = useState("Detecting...");
  const [voiceLang, setVoiceLang] = useState("en-IN");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const recognitionRef = useRef(null);

  /* ================= LOAD DATA ================= */
  useEffect(() => {
    loadData();
    getLocation();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      setError(null);

      const res = await axios.get("http://localhost:5000/violations");

      setData(res.data || []);
      setFiltered(res.data || []);
    } catch (err) {
      console.log(err);
      setError("Failed to load violations data");
    } finally {
      setLoading(false);
    }
  };

  /* ================= FILTER ================= */
  useEffect(() => {
    let temp = [...data];

    if (search.trim()) {
      temp = temp.filter((i) =>
        i.violation?.toLowerCase().includes(search.toLowerCase())
      );
    }

    if (stateFilter !== "ALL") {
      temp = temp.filter((i) => i.state_name === stateFilter);
    }

    setFiltered(temp);
  }, [search, stateFilter, data]);

  /* ================= LOCATION ================= */
  const getLocation = () => {
    navigator.geolocation.getCurrentPosition(async (pos) => {
      try {
        const res = await axios.get(
          `https://nominatim.openstreetmap.org/reverse?format=json&lat=${pos.coords.latitude}&lon=${pos.coords.longitude}`
        );

        setLocation(res.data.address?.state || "India");
      } catch {
        setLocation("India");
      }
    });
  };

  /* ================= CHAT ================= */
  const sendMessage = async (text) => {
    if (!text.trim()) return;

    setMessages((p) => [...p, { role: "user", text }]);
    setInput("");

    navigator.geolocation.getCurrentPosition(async (pos) => {
      try {
        const res = await axios.post("http://localhost:5000/chat", {
          message: text,
          lat: pos.coords.latitude,
          lon: pos.coords.longitude,
          lang: voiceLang,
        });

        const formatted = formatAI(cleanAI(res.data.reply || ""));

        setMessages((p) => [...p, { role: "bot", text: formatted }]);
      } catch (err) {
        setMessages((p) => [
          ...p,
          { role: "bot", text: "Server error ❌ Try again" },
        ]);
      }
    });
  };

  /* ================= VOICE ================= */
  const startVoice = () => {
    const SpeechRecognition =
      window.SpeechRecognition || window.webkitSpeechRecognition;

    if (!SpeechRecognition) return alert("Not supported");

    const recognition = new SpeechRecognition();
    recognition.lang = voiceLang;

    recognition.onresult = (e) => {
      setInput(e.results[0][0].transcript);
    };

    recognition.start();
    recognitionRef.current = recognition;
  };

  const stopVoice = () => recognitionRef.current?.stop();

  /* ================= UI ================= */
  return (
    <div style={styles.page}>
      <div style={styles.location}>📍 {location}</div>

      <h1 style={styles.title}>🚗 DriveLegal AI</h1>

      {/* CHAT */}
      <div style={styles.chatBox}>
        <div style={styles.messages}>
          {messages.map((m, i) => (
            <div
              key={i}
              style={{
                ...styles.msg,
                alignSelf: m.role === "user" ? "flex-end" : "flex-start",
                background: m.role === "user" ? "#1f6feb" : "#333",
              }}
            >
              {m.text}
            </div>
          ))}
        </div>

        <div style={styles.row}>
          <input
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Ask traffic rule..."
            style={styles.input}
          />

          <button onClick={() => sendMessage(input)} style={styles.send}>
            Send
          </button>
        </div>

        <select
          value={voiceLang}
          onChange={(e) => setVoiceLang(e.target.value)}
          style={styles.select}
        >
          <option value="en-IN">English</option>
          <option value="hi-IN">Hindi</option>
          <option value="ta-IN">Tamil</option>
          <option value="te-IN">Telugu</option>
          <option value="ml-IN">Malayalam</option>
          <option value="kn-IN">Kannada</option>
        </select>

        <div style={styles.voiceRow}>
          <button onClick={startVoice} style={styles.start}>🎤 Start</button>
          <button onClick={stopVoice} style={styles.stop}>⛔ Stop</button>
        </div>
      </div>

      {/* FILTER */}
      <div style={styles.filter}>
        <input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search violation..."
          style={styles.input}
        />

        <select
          value={stateFilter}
          onChange={(e) => setStateFilter(e.target.value)}
          style={styles.select}
        >
          <option value="ALL">ALL STATES</option>
          {[...new Set(data.map((i) => i.state_name))].map((s, i) => (
            <option key={i}>{s}</option>
          ))}
        </select>
      </div>

      {/* STATUS */}
      {loading && <p>Loading data...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}

      {/* DATA */}
      <div style={styles.grid}>
        {filtered.map((item) => (
          <div key={item.id} style={styles.card}>
            <h3>🚨 {item.violation}</h3>
            <p>📍 {item.state_name}</p>
            <p>💰 ₹{item.fine_amount}</p>
            <p style={{ color: "#ccc", fontSize: 12 }}>
              {item.description}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
}

/* ================= STYLES ================= */
const styles = {
  page: { background: "#0a0c10", color: "#fff", padding: 20, minHeight: "100vh" },
  location: { position: "absolute", top: 10, right: 10, background: "#222", padding: 6, borderRadius: 10 },
  title: { textAlign: "center" },
  chatBox: { background: "#111", padding: 10, borderRadius: 10 },
  messages: { height: 180, overflowY: "auto" },
  msg: { padding: 10, borderRadius: 10, margin: 5, maxWidth: "70%", whiteSpace: "pre-line" },
  row: { display: "flex", gap: 10 },
  input: { flex: 1, padding: 10, background: "#222", color: "#fff" },
  select: { padding: 10, background: "#222", color: "#fff", marginTop: 10 },
  send: { background: "#1f6feb", color: "#fff", padding: 10 },
  voiceRow: { display: "flex", gap: 10, marginTop: 10 },
  start: { background: "green", padding: 8 },
  stop: { background: "red", padding: 8 },
  filter: { display: "flex", gap: 10, marginTop: 20 },
  grid: { display: "grid", gridTemplateColumns: "repeat(auto-fit,minmax(250px,1fr))", gap: 10, marginTop: 15 },
  card: { background: "#222", padding: 10, borderRadius: 10 },
};