import { useState, useRef, useEffect } from "react";
import axios from "axios";

function ChatBox({ setViolation }) {
  const [text, setText] = useState("");
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [isListening, setIsListening] = useState(false);

  const recognitionRef = useRef(null);
  const chatEndRef = useRef(null);

  /* Auto scroll */
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  /* Speech */
  const speakText = (text) => {
    if (!text) return;
    window.speechSynthesis.cancel();

    const speech = new SpeechSynthesisUtterance(text);
    speech.lang = "en-IN";
    speech.rate = 1;

    window.speechSynthesis.speak(speech);
  };

  /* Voice start */
  const startVoice = () => {
    const SpeechRecognition =
      window.SpeechRecognition || window.webkitSpeechRecognition;

    if (!SpeechRecognition) {
      alert("Voice input not supported");
      return;
    }

    const recognition = new SpeechRecognition();
    recognition.lang = "en-IN";
    recognition.continuous = true;
    recognition.interimResults = true;

    recognition.onstart = () => setIsListening(true);

    recognition.onresult = (event) => {
      let transcript = "";
      for (let i = event.resultIndex; i < event.results.length; i++) {
        transcript += event.results[i][0].transcript;
      }
      setText(transcript);
    };

    recognition.onerror = () => setIsListening(false);
    recognition.onend = () => setIsListening(false);

    recognitionRef.current = recognition;
    recognition.start();
  };

  const stopVoice = () => {
    recognitionRef.current?.stop();
    setIsListening(false);
  };

  /* Send message */
  const sendMessage = async () => {
    if (!text.trim()) return;

    const userText = text;
    setText("");

    setMessages((prev) => [...prev, { role: "user", text: userText }]);
    setLoading(true);

    try {
      const res = await axios.post("http://localhost:5000/chat", {
        message: userText,
        lat: 13.0827,
        lon: 80.2707,
      });

      const data = res.data;

      setMessages((prev) => [
        ...prev,
        { role: "bot", text: data.reply },
      ]);

      /* SAFE: only if backend sends it */
      if (setViolation && data?.violationData) {
        setViolation(data.violationData);
      }

      speakText(data.reply);
    } catch (err) {
      setMessages((prev) => [
        ...prev,
        { role: "bot", text: "Server error ❌" },
      ]);
    }

    setLoading(false);
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.header}>
        💬 DriveLegal AI Assistant
      </div>

      {/* CHAT BOX */}
      <div style={styles.chatBox}>
        {messages.length === 0 && (
          <p style={{ opacity: 0.5, textAlign: "center" }}>
            Ask anything about traffic rules 🚗
          </p>
        )}

        {messages.map((msg, i) => (
          <div key={i} style={{ marginBottom: 10 }}>
            <b>{msg.role === "user" ? "You" : "AI"}:</b> {msg.text}
          </div>
        ))}

        {loading && <p>Thinking...</p>}

        <div ref={chatEndRef} />
      </div>

      {/* INPUT */}
      <div style={styles.inputBox}>
        <input
          value={text}
          onChange={(e) => setText(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder="Ask traffic question..."
          style={styles.input}
        />

        <button onClick={startVoice} style={styles.voiceBtn}>
          🎤
        </button>

        <button onClick={stopVoice} style={styles.stopBtn}>
          ⏹
        </button>

        <button onClick={sendMessage} style={styles.button}>
          Send 🚀
        </button>
      </div>
    </div>
  );
}

export default ChatBox;

/* SAME UI COLORS (NOT CHANGED) */
const styles = {
  container: {
    height: "80vh",
    display: "flex",
    flexDirection: "column",
    borderRadius: "20px",
    overflow: "hidden",
    background: "linear-gradient(160deg, rgba(255,255,255,0.05), rgba(255,255,255,0.02))",
    border: "1px solid rgba(139,92,246,0.3)",
  },

  header: {
    padding: "14px",
    color: "white",
    fontWeight: "700",
    background: "rgba(99,102,241,0.18)",
  },

  chatBox: {
    flex: 1,
    padding: 15,
    overflowY: "auto",
    color: "#e2e8f0",
  },

  inputBox: {
    display: "flex",
    gap: 8,
    padding: 10,
    background: "rgba(0,0,0,0.2)",
  },

  input: {
    flex: 1,
    padding: 10,
    borderRadius: 10,
    border: "1px solid rgba(255,255,255,0.1)",
    background: "rgba(255,255,255,0.05)",
    color: "white",
  },

  button: {
    background: "#6366f1",
    color: "white",
    border: "none",
    padding: "10px 14px",
    borderRadius: 10,
    cursor: "pointer",
  },

  voiceBtn: {
    background: "#34d399",
    border: "none",
    padding: "10px",
    borderRadius: 10,
    cursor: "pointer",
  },

  stopBtn: {
    background: "#ef4444",
    border: "none",
    padding: "10px",
    borderRadius: 10,
    cursor: "pointer",
  },
};