import { supabase } from "./supabaseClient";

/**
 * Test Supabase connection + auth session
 */
export const testConnection = async () => {
  try {
    const { data, error } = await supabase.auth.getSession();

    console.log("✅ Supabase Session Data:", data);

    if (error) {
      console.log("❌ Supabase Error:", error.message);
    } else {
      console.log("✅ No error, connection working fine");
    }
  } catch (err) {
    console.log("❌ Unexpected error:", err.message);
  }
};