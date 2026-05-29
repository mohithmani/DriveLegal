import fs from "fs";
import pool from "./db.js";

console.log("🔥 Importing questions...");

// read file
const raw = fs.readFileSync("./traffic_questions.json", "utf-8");
const data = JSON.parse(raw);

for (const q of data.questions) {
  try {
    // duplicate check
    const check = await pool.query(
      `SELECT id FROM traffic_questions WHERE LOWER(question) = LOWER($1)`,
      [q.question]
    );

    if (check.rows.length > 0) {
      console.log("⚠️ Skipped:", q.question);
      continue;
    }

    // insert
    await pool.query(
      `INSERT INTO traffic_questions
      (question, option_a, option_b, option_c, option_d, correct_answer, state_name)
      VALUES ($1,$2,$3,$4,$5,$6,$7)`,
      [
        q.question,
        q.option_a,
        q.option_b,
        q.option_c,
        q.option_d,
        q.correct_answer,
        q.state_name
      ]
    );

    console.log("✅ Inserted:", q.question);

  } catch (err) {
    console.log("❌ Error:", q.question, err.message);
  }
}

console.log("🎉 DONE");