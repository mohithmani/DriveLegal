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
      [questionId]: option,
    }));
  };

  /* ================= SUBMIT ================= */
  const handleSubmit = async () => {
    try {
      if (!questions.length) return;

      const formattedAnswers = questions.map((q) => ({
        id: q.id,
        selected: answers[q.id] || null,
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

  /* ================= QUIZ UI ================= */
  return (
    <div style={{ padding: 20, maxWidth: 850, margin: "auto" }}>
      <h2 style={{ textAlign: "center" }}>🚗 DriveLegal Quiz</h2>

      {/* QUESTIONS */}
      {!result &&
        questions.map((q, index) => {
          const options = q.options || {
            A: q.option_a,
            B: q.option_b,
            C: q.option_c,
            D: q.option_d,
          };

          return (
            <div
              key={q.id}
              style={{
                border: "1px solid #ddd",
                borderRadius: 10,
                padding: 15,
                marginBottom: 15,
              }}
            >
              <h4>
                {index + 1}. {q.question}
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
                      padding: "12px",
                      borderRadius: 8,
                      cursor: "pointer",
                      border:
                        answers[q.id] === opt
                          ? "2px solid green"
                          : "1px solid #ccc",
                      background:
                        answers[q.id] === opt ? "#4CAF50" : "#fff",
                      color:
                        answers[q.id] === opt ? "#fff" : "#000",
                    }}
                  >
                    <b>{opt}.</b> {options[opt]}
                  </button>
                ))}
              </div>
            </div>
          );
        })}

      {/* SUBMIT BUTTON */}
      {!result && questions.length > 0 && (
        <button
          onClick={handleSubmit}
          style={{
            width: "100%",
            padding: 12,
            background: "#403e3e",
            color: "#ffffff",
            border: "none",
            borderRadius: 8,
            marginTop: 10,
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
          }}
        >
          <h2>🏆 Result</h2>
          <h3>
            Score: {result.score} / {result.total}
          </h3>
          <h3>Percentage: {result.percentage}%</h3>

          {/* REVIEW */}
          {result.results.map((r, index) => (
            <div
              key={r.id}
              style={{
                border: r.isCorrect ? "2px solid green" : "2px solid red",
                padding: 10,
                marginTop: 10,
                borderRadius: 8,
              }}
            >
              <p>
                <b>{index + 1}. Question:</b> {r.question}
              </p>

              <p><b>Options:</b></p>
              <p>A. {r.options?.A}</p>
              <p>B. {r.options?.B}</p>
              <p>C. {r.options?.C}</p>
              <p>D. {r.options?.D}</p>

              <p style={{ color: "blue" }}>
                Your Answer: {r.selected}
              </p>

              <p style={{ color: "green" }}>
                Correct Answer: {r.correct_answer}
              </p>

              <p>
                Status: {r.isCorrect ? "✅ Correct" : "❌ Wrong"}
              </p>
            </div>
          ))}

          <button
            onClick={loadQuiz}
            style={{
              marginTop: 15,
              padding: 10,
              width: "100%",
              background: "#2196F3",
              color: "#fff",
              border: "none",
              borderRadius: 8,
            }}
          >
            🔄 Try Again
          </button>
        </div>
      )}
    </div>
  );
}