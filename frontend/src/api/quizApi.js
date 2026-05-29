import { useEffect, useState } from "react";
import axios from "axios";

const API = "http://localhost:5000";

export default function QuizPage() {
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(true);

  /* ================= LOAD QUIZ ================= */
  useEffect(() => {
    fetchQuiz();
  }, []);

  const fetchQuiz = async () => {
    try {
      setLoading(true);

      const res = await axios.get(`${API}/quiz`);

      // FIX: always ensure array
      setQuestions(Array.isArray(res.data.questions) ? res.data.questions : []);
    } catch (err) {
      console.log("Quiz load error:", err);
      setQuestions([]);
    } finally {
      setLoading(false);
    }
  };

  /* ================= SELECT ANSWER ================= */
  const handleSelect = (qid, option) => {
    setAnswers((prev) => ({
      ...prev,
      [String(qid)]: option,
    }));
  };

  /* ================= SAFE OPTION ================= */
  const getOption = (q, opt) => {
    if (!q || !q.options) return "Not Available";
    return q.options?.[opt] || "Not Available";
  };

  /* ================= SUBMIT ================= */
  const handleSubmit = async () => {
    try {
      const payload = Object.keys(answers).map((id) => ({
        id: Number(id),
        selected: answers[id] || null,
      }));

      const res = await axios.post(`${API}/quiz/submit`, {
        answers: payload,
      });

      setResult(res.data);
    } catch (err) {
      console.log("Submit error:", err);
    }
  };

  /* ================= LOADING ================= */
  if (loading) {
    return (
      <div style={{ padding: 20 }}>
        <h3>Loading quiz...</h3>
      </div>
    );
  }

  return (
    <div style={{ padding: 20, maxWidth: 800, margin: "auto" }}>
      <h2>🚗 DriveLegal Quiz</h2>

      {/* QUIZ LIST */}
      {!result &&
        questions.map((q, index) => (
          <div
            key={q.id}
            style={{
              border: "1px solid #ddd",
              padding: 15,
              marginBottom: 15,
              borderRadius: 8,
            }}
          >
            <h4>
              {index + 1}. {q.question || "Question not available"}
            </h4>

            <div>
              {["A", "B", "C", "D"].map((opt) => (
                <button
                  key={opt}
                  onClick={() => handleSelect(q.id, opt)}
                  style={{
                    margin: 5,
                    padding: 10,
                    background:
                      answers[String(q.id)] === opt ? "#4CAF50" : "#f2f2f2",
                    color: answers[String(q.id)] === opt ? "white" : "black",
                    border: "none",
                    cursor: "pointer",
                    borderRadius: 5,
                  }}
                >
                  {opt}. {getOption(q, opt)}
                </button>
              ))}
            </div>
          </div>
        ))}

      {/* SUBMIT */}
      {!result && questions.length > 0 && (
        <button
          onClick={handleSubmit}
          style={{
            padding: 12,
            width: "100%",
            background: "black",
            color: "white",
            border: "none",
            borderRadius: 6,
            cursor: "pointer",
          }}
        >
          Submit Quiz
        </button>
      )}

      {/* RESULT */}
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

          <p style={{ fontSize: 18 }}>{result.message}</p>

          {/* REVIEW */}
          {result.results?.length > 0 && (
            <div style={{ marginTop: 15 }}>
              <h3>📘 Review</h3>

              {result.results.map((r, i) => (
                <div
                  key={r.id}
                  style={{
                    padding: 10,
                    border: r.isCorrect ? "2px solid green" : "2px solid red",
                    marginTop: 10,
                    borderRadius: 8,
                  }}
                >
                  <p>
                    <b>{i + 1}. Question:</b> {r.question}
                  </p>

                  {/* FIXED ANSWER DISPLAY */}
                  <p>
                    <b>Your Answer:</b>{" "}
                    {r.selected
                      ? `${r.selected}. ${
                          r.options?.[r.selected] || "Not Available"
                        }`
                      : "Not Answered"}
                  </p>

                  <p>
                    <b>Correct Answer:</b>{" "}
                    {r.correct_answer
                      ? `${r.correct_answer}. ${
                          r.options?.[r.correct_answer] || "Not Available"
                        }`
                      : "Not Available"}
                  </p>

                  <p>
                    <b>Status:</b>{" "}
                    {r.isCorrect ? "✅ Correct" : "❌ Wrong"}
                  </p>
                </div>
              ))}
            </div>
          )}

          <button
            onClick={() => {
              setResult(null);
              setAnswers({});
              fetchQuiz();
            }}
            style={{
              marginTop: 10,
              padding: 10,
              background: "#2196F3",
              color: "white",
              border: "none",
              borderRadius: 6,
            }}
          >
            Try Again
          </button>
        </div>
      )}
    </div>
  );
}