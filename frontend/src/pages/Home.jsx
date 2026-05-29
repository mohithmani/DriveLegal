import { useNavigate } from "react-router-dom";

function Home() {
  const navigate = useNavigate();

  return (
    <div style={styles.page}>
      {/* TITLE */}
      <div style={styles.header}>
        <h1 style={styles.title}>
          🚗 DriveLegal AI
        </h1>

        <p style={styles.sub}>
          Smart Indian Traffic Law
          Assistant
        </p>
      </div>

      {/* OPTIONS */}
      <div style={styles.grid}>
        {/* LIVE MAP */}
        <div
          style={styles.card}
          onClick={() =>
            navigate("/map")
          }
        >
          <div style={styles.icon}>
            📍
          </div>

          <h3>Live Map</h3>

          <p>
            Track GPS location
          </p>
        </div>

        {/* AI CHAT */}
        <div
          style={styles.card}
          onClick={() =>
            navigate("/chat")
          }
        >
          <div style={styles.icon}>
            💬
          </div>

          <h3>AI Chat</h3>

          <p>
            Ask traffic law
            questions
          </p>
        </div>

        {/* VIOLATIONS */}
        <div
          style={styles.card}
          onClick={() =>
            navigate(
              "/violations"
            )
          }
        >
          <div style={styles.icon}>
            🚨
          </div>

          <h3>
            Violation Data
          </h3>

          <p>
            View database
            rules
          </p>
        </div>

        {/* QUIZ */}
        <div
          style={styles.card}
          onClick={() =>
            navigate("/quiz")
          }
        >
          <div style={styles.icon}>
            🧠
          </div>

          <h3>
            Traffic Quiz
          </h3>

          <p>
            Test your driving
            knowledge
          </p>
        </div>

        {/* SAFETY ROUTE */}
        <div
          style={styles.card}
          onClick={() =>
            navigate(
              "/safety-route"
            )
          }
        >
          <div style={styles.icon}>
            🛣️
          </div>

          <h3>
            Safety Route
          </h3>

          <p>
            Find safest route
            to destination
          </p>
        </div>
      </div>
    </div>
  );
}

/* ================= STYLES ================= */

const styles = {
  page: {
    minHeight: "100vh",
    background: "#0a0c10",
    color: "#fff",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    padding: "20px",
  },

  header: {
    textAlign: "center",
    marginBottom: "40px",
  },

  title: {
    fontSize: "38px",
    margin: 0,
  },

  sub: {
    fontSize: "15px",
    color: "#aaa",
    marginTop: "10px",
  },

  grid: {
    display: "grid",
    gridTemplateColumns:
      "repeat(auto-fit, minmax(220px, 1fr))",
    gap: "20px",
    width: "85%",
    maxWidth: "1000px",
  },

  card: {
    background: "#13161e",
    padding: "25px",
    borderRadius: "18px",
    textAlign: "center",
    cursor: "pointer",
    border:
      "1px solid rgba(255,255,255,0.08)",
    transition:
      "transform 0.2s ease, box-shadow 0.2s ease",
    boxShadow:
      "0 4px 10px rgba(0,0,0,0.2)",
  },

  icon: {
    fontSize: "42px",
    marginBottom: "12px",
  },
};

export default Home;