import { useEffect, useState } from "react";
import axios from "axios";

const API = "http://localhost:5000";

export default function QuizPage() {
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);

  /* ================= LOAD QUIZ ================= */
  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    try {
      setLoading(true);
      setResult(null);
      setAnswers({});

      const res = await axios.get(`${API}/quiz`);
      setQuestions(res.data.questions || []);
    } catch (err) {
      console.error("Error loading quiz:", err);
      setQuestions([]);
    } finally {
      setLoading(false);
    }
  };

  /* ================= SELECT ANSWER ================= */
  const handleSelect = (questionId, option) => {
    setAnswers((prev) => ({
      ...prev,
      [String(questionId)]: option,
    }));
  };

  /* ================= SAFE TEXT ================= */
  const getOptionText = (options, key) => {
    if (!key) return "Not Answered";
    if (!options || typeof options !== "object") {
      return `${key} (Not Available)`;
    }

    const value = options[key];

    if (!value || value === "Not Available") {
      return `${key} (Not Available)`;
    }

    return `${key}. ${value}`;
  };

  /* ================= SUBMIT QUIZ ================= */
  const handleSubmit = async () => {
    try {
      if (!questions.length) return;

      const formattedAnswers = questions.map((q) => ({
        id: q.id,
        selected: answers[String(q.id)] || null,
      }));

      const res = await axios.post(`${API}/quiz/submit`, {
        answers: formattedAnswers,
      });

      setResult(res.data);
    } catch (err) {
      console.error("Submit error:", err);
    }
  };

  /* ================= LOADING ================= */
  if (loading) {
    return (
      <div style={{ padding: 20 }}>
        <h3>🚗 Loading quiz...</h3>
      </div>
    );
  }

  return (
    <div style={{ padding: 20, maxWidth: 850, margin: "auto" }}>
      <h2 style={{ textAlign: "center" }}>🚗 DriveLegal Quiz</h2>

      {/* ================= QUESTIONS ================= */}
      {!result &&
        questions.map((q, index) => (
          <div
            key={q.id}
            style={{
              border: "1px solid #ddd",
              borderRadius: 10,
              padding: 15,
              marginBottom: 15,
              background: "#fff",
            }}
          >
            <h4>
              {index + 1}. {q.question || "Question not available"}
            </h4>

            <div style={{ marginTop: 10 }}>
              {["A", "B", "C", "D"].map((opt) => (
                <button
                  key={opt}
                  onClick={() => handleSelect(q.id, opt)}
                  style={{
                    display: "block",
                    width: "100%",
                    textAlign: "left",
                    marginBottom: 10,
                    padding: "12px 15px",
                    borderRadius: 8,
                    cursor: "pointer",
                    border:
                      answers[String(q.id)] === opt
                        ? "2px solid #4CAF50"
                        : "1px solid #ccc",
                    background:
                      answers[String(q.id)] === opt ? "#4CAF50" : "#fff",
                    color:
                      answers[String(q.id)] === opt ? "#fff" : "#000",
                  }}
                >
                  <b>{opt}.</b>{" "}
                  {q[`option_${opt.toLowerCase()}`] || "Not Available"}
                </button>
              ))}
            </div>
          </div>
        ))}

      {/* ================= SUBMIT ================= */}
      {!result && questions.length > 0 && (
        <button
          onClick={handleSubmit}
          style={{
            width: "100%",
            padding: 12,
            background: "#000",
            color: "white",
            border: "none",
            borderRadius: 8,
            cursor: "pointer",
            marginTop: 10,
            fontSize: 16,
          }}
        >
          Submit Quiz
        </button>
      )}

      {/* ================= RESULT ================= */}
      {result && (
        <div
          style={{
            marginTop: 20,
            padding: 20,
            border: "2px solid green",
            borderRadius: 10,
            background: "#f5fff5",
            maxWidth: 800,
            margin: "auto",
          }}
        >
          <h2>🏆 Quiz Result</h2>

          <h3>
            Score: {result.score} / {result.total}
          </h3>

          <h3>Percentage: {result.percentage}%</h3>

          <p>{result.message}</p>

          {/* ================= FULL REVIEW ================= */}
          {result.results?.length > 0 && (
            <div style={{ marginTop: 20 }}>
              <h3>📘 Full Answer Review</h3>

              {result.results.map((r, index) => {
                const isCorrect =
                  r.selected &&
                  r.correct_answer &&
                  r.selected === r.correct_answer;

                return (
                  <div
                    key={r.id}
                    style={{
                      border: isCorrect
                        ? "2px solid green"
                        : "2px solid red",
                      padding: 12,
                      marginTop: 12,
                      borderRadius: 8,
                      background: isCorrect
                        ? "#f0fff0"
                        : "#fff0f0",
                    }}
                  >
                    {/* QUESTION */}
                    <p>
                      <b>{index + 1}. Question:</b>{" "}
                      {r.question || "Not available"}
                    </p>

                    {/* OPTIONS */}
                    <div style={{ marginTop: 8 }}>
                      <p><b>Options:</b></p>
                      <p>A. {r.options?.A || "Not Available"}</p>
                      <p>B. {r.options?.B || "Not Available"}</p>
                      <p>C. {r.options?.C || "Not Available"}</p>
                      <p>D. {r.options?.D || "Not Available"}</p>
                    </div>

                    {/* USER ANSWER */}
                    <p style={{ marginTop: 8, color: "blue" }}>
                      <b>Your Answer:</b>{" "}
                      {r.selected
                        ? `${r.selected}. ${
                            r.options?.[r.selected] || "Not Available"
                          }`
                        : "Not Answered"}
                    </p>

                    {/* CORRECT ANSWER */}
                    <p style={{ color: "green" }}>
                      <b>Correct Answer:</b>{" "}
                      {r.correct_answer
                        ? `${r.correct_answer}. ${
                            r.options?.[r.correct_answer] ||
                            "Not Available"
                          }`
                        : "Not Available"}
                    </p>

                    {/* STATUS */}
                    <p>
                      <b>Status:</b>{" "}
                      {isCorrect ? "✅ Correct" : "❌ Wrong"}
                    </p>
                  </div>
                );
              })}
            </div>
          )}

          <button
            onClick={loadQuiz}
            style={{
              marginTop: 15,
              padding: 12,
              background: "#2196F3",
              color: "white",
              border: "none",
              borderRadius: 8,
              width: "100%",
            }}
          >
            🔄 Try New Quiz
          </button>
        </div>
      )}
    </div>
  );
}