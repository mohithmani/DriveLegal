import pool from "./db.js";

async function test() {
  try {
    const result =
      await pool.query(
        "SELECT NOW()"
      );

    console.log(
      "✅ Database Connected Successfully"
    );

    console.log(result.rows);

  } catch (error) {
    console.error(
      "❌ Database Error:",
      error
    );
  }
}

test();