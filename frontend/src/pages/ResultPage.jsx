import { useLocation, useNavigate } from "react-router-dom";
import { useEffect } from "react";

export default function ResultPage() {
  const { state } = useLocation();
  const navigate = useNavigate();

  // If user refreshes page and state is lost
  useEffect(() => {
    if (!state) {
      navigate("/");
    }
  }, [state, navigate]);

  if (!state) {
    return null;
  }

  const { score, total, percentage, message } = state;

  // Performance badge logic
  const getBadge = () => {
    if (percentage >= 80) return "🔥 Excellent Driver";
    if (percentage >= 50) return "🚗 Good Driver";
    return "⚠️ Needs Improvement";
  };

  const handleRetry = () => {
    navigate("/");
  };

  return (
    <div
      style={{
        padding: 20,
        maxWidth: 600,
        margin: "auto",
        textAlign: "center",
      }}
    >
      <h2>🏆 Quiz Result</h2>

      {/* SCORE CARD */}
      <div
        style={{
          border: "2px solid #4CAF50",
          borderRadius: 10,
          padding: 20,
          marginTop: 20,
        }}
      >
        <h3>
          Score: {score} / {total}
        </h3>

        <h3>Percentage: {percentage.toFixed(1)}%</h3>

        <h2 style={{ marginTop: 10 }}>{getBadge()}</h2>

        <p style={{ fontSize: 18, marginTop: 10 }}>{message}</p>
      </div>

      {/* PROGRESS BAR */}
      <div
        style={{
          marginTop: 20,
          height: 20,
          background: "#eee",
          borderRadius: 10,
          overflow: "hidden",
        }}
      >
        <div
          style={{
            width: `${percentage}%`,
            height: "100%",
            background:
              percentage >= 80
                ? "green"
                : percentage >= 50
                ? "orange"
                : "red",
            transition: "0.5s",
          }}
        />
      </div>

      {/* ACTION BUTTONS */}
      <div style={{ marginTop: 20 }}>
        <button
          onClick={handleRetry}
          style={{
            padding: "10px 20px",
            marginRight: 10,
            background: "#2196F3",
            color: "white",
            border: "none",
            borderRadius: 6,
            cursor: "pointer",
          }}
        >
          🔄 Try Again
        </button>

        <button
          onClick={() => navigate("/")}
          style={{
            padding: "10px 20px",
            background: "#333",
            color: "white",
            border: "none",
            borderRadius: 6,
            cursor: "pointer",
          }}
        >
          🏠 Home
        </button>
      </div>
    </div>
  );
}