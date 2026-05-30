import express from "express";
import cors from "cors";
import "dotenv/config";
import OpenAI from "openai";
import pool from "./db.js";
import fetch from "node-fetch";

const app = express();
const PORT = process.env.PORT || 5000;

/* ================= GLOBAL CRASH PROTECTION ================= */
process.on("uncaughtException", (err) => {
  console.error("❌ Uncaught Exception:", err.message);
});

process.on("unhandledRejection", (err) => {
  console.error("❌ Unhandled Rejection:", err);
});

/* ================= MIDDLEWARE ================= */
app.use(cors({ origin: "http://localhost:5173" }));
app.use(express.json());

/* ================= ROOT ================= */
app.get("/", (req, res) => {
  res.send("DriveLegal backend running 🚗");
});

/* ================= TEST DB ================= */
app.get("/test-db", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT COUNT(*) AS total FROM traffic_questions"
    );

    res.json({
      success: true,
      total: Number(result.rows[0].total),
    });
  } catch (err) {
    console.error("DB Test Error:", err.message);
    res.status(500).json({ error: "DB connection failed" });
  }
});

/* ================= VIOLATIONS API ================= */
app.get("/violations", async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT id, state_name, violation, fine_amount, description
      FROM traffic_rules
      ORDER BY id ASC
    `);

    res.json(result.rows);
  } catch (err) {
    console.error("Violations Error:", err.message);
    res.status(500).json({ error: "Failed to fetch violations" });
  }
});

/* ================= GROQ CLIENT ================= */
const client = new OpenAI({
  apiKey: process.env.GROQ_API_KEY,
  baseURL: "https://api.groq.com/openai/v1",
});

/* ================= LANGUAGE DETECTION ================= */
const detectLanguage = (text = "") => {
  if (/[\u0B80-\u0BFF]/.test(text)) return "tamil";
  if (/[\u0900-\u097F]/.test(text)) return "hindi";
  if (/[\u0C00-\u0C7F]/.test(text)) return "telugu";
  if (/[\u0C80-\u0CFF]/.test(text)) return "kannada";
  if (/[\u0D00-\u0D7F]/.test(text)) return "malayalam";
  return "english";
};

/* ================= SYSTEM PROMPT ================= */
const getSystemPrompt = (lang, state) => {
  return `
You are DriveLegal AI 🚗

RULES:
• Only point-wise answers
• Each line starts with •
• 4–6 points max
• Use ₹ for fines

STATE: ${state || "India"}
LANGUAGE: ${lang}
`;
};

/* ================= GPS → STATE ================= */
const getStateFromGPS = async (lat, lon) => {
  try {
    const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}`;

    const res = await fetch(url, {
      headers: { "User-Agent": "DriveLegal-App" },
    });

    const data = await res.json();
    return data.address?.state || null;
  } catch (err) {
    console.error("GPS Error:", err.message);
    return null;
  }
};

/* ================= DB SEARCH ================= */
const searchTrafficRule = async (message, state) => {
  try {
    const query = `
      SELECT *
      FROM traffic_rules
      WHERE LOWER(violation) LIKE LOWER($1)
         OR LOWER(description) LIKE LOWER($1)
      ${state ? "AND LOWER(state_name) = LOWER($2)" : ""}
      LIMIT 1
    `;

    const values = state
      ? [`%${message}%`, state]
      : [`%${message}%`];

    const result = await pool.query(query, values);
    return result.rows[0] || null;
  } catch (err) {
    console.error("Search Error:", err.message);
    return null;
  }
};

/* ================= CHAT API ================= */
app.post("/chat", async (req, res) => {
  try {
    const { message, lat, lon } = req.body;

    if (!message) {
      return res.status(400).json({ reply: "Message required" });
    }

    const lang = detectLanguage(message);

    let state = null;
    if (lat && lon) {
      state = await getStateFromGPS(lat, lon);
    }

    const dbRule = await searchTrafficRule(message, state);

    let userPrompt = message;

    if (dbRule) {
      userPrompt = `
User Question: ${message}

Violation: ${dbRule.violation}
Fine: ₹${dbRule.fine_amount}
State: ${dbRule.state_name}
Description: ${dbRule.description}
`;
    }

    const response = await client.chat.completions.create({
      model: "llama-3.1-8b-instant",
      messages: [
        { role: "system", content: getSystemPrompt(lang, state) },
        { role: "user", content: userPrompt },
      ],
    });

    res.json({
      reply: response.choices[0].message.content,
      state,
      language: lang,
      databaseMatched: !!dbRule,
    });

  } catch (err) {
    console.error("Chat Error:", err.message);
    res.status(500).json({ reply: "Server error" });
  }
});

/* ================= QUIZ API ================= */
app.get("/quiz", async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT id, question, option_a, option_b, option_c, option_d, correct_answer
      FROM traffic_questions
      ORDER BY RANDOM()
      LIMIT 10
    `);

    res.json({ success: true, questions: result.rows });
  } catch (err) {
    console.error("Quiz Error:", err.message);
    res.status(500).json({ error: "Failed to load quiz" });
  }
});

/* ================= QUIZ SUBMIT ================= */
app.post("/quiz/submit", async (req, res) => {
  try {
    const { answers } = req.body;

    let score = 0;
    const results = [];

    for (const a of answers) {
      const r = await pool.query(
        `SELECT 
          id,
          question,
          option_a,
          option_b,
          option_c,
          option_d,
          correct_answer
         FROM traffic_questions 
         WHERE id=$1`,
        [a.id]
      );

      const q = r.rows[0];

      const correct = q?.correct_answer;
      const selected = a.selected;

      const isCorrect = correct === selected;

      if (isCorrect) score++;

      results.push({
        id: q.id,
        question: q.question,

        options: {
          A: q.option_a,
          B: q.option_b,
          C: q.option_c,
          D: q.option_d,
        },

        selected,
        correct_answer: correct,
        isCorrect,
      });
    }

    res.json({
      score,
      total: answers.length,
      percentage: Math.round((score / answers.length) * 100),
      results,
    });

  } catch (err) {
    console.error("Quiz Submit Error:", err.message);
    res.status(500).json({ error: "Failed to submit quiz" });
  }
});
/* ================= START SERVER ================= */
app.listen(PORT, () => {
  console.log(`🚀 Server running: http://localhost:${PORT}`);
});