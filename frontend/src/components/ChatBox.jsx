import { useState, useRef, useEffect } from "react";
import axios from "axios";

function ChatBox({ setViolation }) {
  const [text, setText] = useState("");
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(false);

  const [isListening, setIsListening] = useState(false);
  const recognitionRef = useRef(null);

  const chatEndRef = useRef(null);

  // 🔁 Auto scroll
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  // 🔊 Speak AI reply
  const speakText = (text) => {
    if (!text) return;

    window.speechSynthesis.cancel();
    const speech = new SpeechSynthesisUtterance(text);

    speech.lang = "en-IN";
    speech.rate = 1;

    window.speechSynthesis.speak(speech);
  };

  // 🎤 START VOICE INPUT
  const startVoice = () => {
    const SpeechRecognition =
      window.SpeechRecognition || window.webkitSpeechRecognition;

    if (!SpeechRecognition) {
      alert("Voice input not supported in this browser");
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

  // ⛔ STOP VOICE INPUT
  const stopVoice = () => {
    if (recognitionRef.current) {
      recognitionRef.current.stop();
      setIsListening(false);
    }
  };

  // 🚀 SEND MESSAGE
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

      if (setViolation) setViolation(data.violationData);

      speakText(data.reply);
    } catch (err) {
      setMessages((prev) => [
        ...prev,
        { role: "bot", text: "Server error ❌" },
      ]);
    }

    setLoading(false);
  };

  return (
    <div style={styles.container}>

      {/* HEADER */}
      <div style={styles.header}>
        💬 DriveLegal AI Assistant
      </div>

      {/* CHAT AREA */}
      <div style={styles.chatBox}>
        {messages.map((msg, i) => (
          <div
            key={i}
            style={{
              ...styles.message,
              alignSelf: msg.role === "user" ? "flex-end" : "flex-start",
              background: msg.role === "user" ? "#2563eb" : "#f1f5f9",
              color: msg.role === "user" ? "#fff" : "#111",
            }}
          >
            {msg.text}
          </div>
        ))}

        {loading && (
          <div style={styles.loading}>Thinking... 🤖</div>
        )}

        <div ref={chatEndRef} />
      </div>

      {/* INPUT AREA */}
      <div style={styles.inputBox}>
        <input
          value={text}
          onChange={(e) => setText(e.target.value)}
          placeholder="Ask traffic law question..."
          style={styles.input}
        />

        {/* 🎤 VOICE CONTROLS */}
        {!isListening ? (
          <button onClick={startVoice} style={styles.voiceBtn}>
            🎤 Start
          </button>
        ) : (
          <button onClick={stopVoice} style={styles.stopBtn}>
            ⏹ Stop
          </button>
        )}

        <button onClick={sendMessage} style={styles.button}>
          Send
        </button>
      </div>

      {/* LISTENING STATUS */}
      {isListening && (
        <div style={styles.listening}>
          🎙️ Listening...
        </div>
      )}
    </div>
  );
}

/* 🎨 STYLES */
const styles = {
  container: {
    height: "80vh",
    display: "flex",
    flexDirection: "column",
    borderRadius: "20px",
    background: "#ffffff",
    boxShadow: "0 10px 30px rgba(0,0,0,0.1)",
    overflow: "hidden",
  },

  header: {
    padding: "15px",
    background: "#0f172a",
    color: "#fff",
    textAlign: "center",
    fontWeight: "bold",
  },

  chatBox: {
    flex: 1,
    padding: "15px",
    overflowY: "auto",
    display: "flex",
    flexDirection: "column",
    gap: "10px",
  },

  message: {
    padding: "10px 14px",
    borderRadius: "12px",
    maxWidth: "75%",
    fontSize: "14px",
  },

  inputBox: {
    display: "flex",
    gap: "8px",
    padding: "10px",
    borderTop: "1px solid #ddd",
  },

  input: {
    flex: 1,
    padding: "10px",
    borderRadius: "10px",
    border: "1px solid #ccc",
  },

  button: {
    padding: "10px 14px",
    background: "#2563eb",
    color: "#fff",
    border: "none",
    borderRadius: "10px",
    cursor: "pointer",
  },

  voiceBtn: {
    padding: "10px 12px",
    background: "#22c55e",
    color: "#fff",
    border: "none",
    borderRadius: "10px",
    cursor: "pointer",
  },

  stopBtn: {
    padding: "10px 12px",
    background: "#ef4444",
    color: "#fff",
    border: "none",
    borderRadius: "10px",
    cursor: "pointer",
  },

  loading: {
    fontSize: "14px",
    color: "gray",
  },

  listening: {
    textAlign: "center",
    padding: "6px",
    background: "#dcfce7",
    color: "#16a34a",
    fontWeight: "bold",
  },
};

export default ChatBox;