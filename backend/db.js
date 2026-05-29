import pg from "pg";
import dotenv from "dotenv";

dotenv.config();

const pool = new pg.Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false,
  },
});

/* 🔍 DEBUG (REMOVE LATER) */
pool.connect()
  .then(() => console.log("✅ Database connected successfully (Neon)"))
  .catch((err) => console.error("❌ DB Connection Error:", err.message));

export default pool;