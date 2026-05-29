import fs from "fs";
import pool from "./db.js";

const raw = fs.readFileSync(
  "./data/trafficRules.json",
  "utf-8"
);

const data = JSON.parse(raw);

const importData = async () => {
  try {
    console.log("📦 Importing traffic violations data...");

    for (const stateObj of data.states) {
      const state = stateObj.state;

      for (const v of stateObj.violations) {

        await pool.query(
          `
          INSERT INTO traffic_violations (
            state_name,
            offence_name,
            normalized_name,
            category,
            section,
            severity,
            first_offence_fine,
            repeat_offence_fine,
            description,
            keywords
          )
          VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
          `,
          [
            state,
            v.offence_name,
            v.normalized_name,
            v.category,
            v.section,
            v.severity,
            v.first_offence_fine,
            v.repeat_offence_fine,
            v.description,
            (v.keywords || []).join(", ")
          ]
        );

      }
    }

    console.log("✅ Import completed successfully");
    process.exit(0);

  } catch (err) {
    console.error("❌ Import Error:", err.message);
    process.exit(1);
  }
};

importData();