import { useEffect } from "react";
import { supabase } from "./supabaseClient";

export default function QuizPage() {

  // ✅ CHECK USER LOGIN
  useEffect(() => {
    const checkUser = async () => {
      const { data } = await supabase.auth.getUser();

      if (!data.user) {
        window.location.href = "/login";
      }
    };

    checkUser();
  }, []);

  // ✅ LOGOUT FUNCTION (INSIDE COMPONENT)
  const logout = async () => {
    await supabase.auth.signOut();
    window.location.href = "/login";
  };

  return (
    <div style={{ padding: 20 }}>
      <h2>🚗 DriveLegal Quiz</h2>

      {/* Your quiz UI will be here */}
      
      <button
        onClick={logout}
        style={{
          marginTop: 20,
          padding: 10,
          background: "red",
          color: "white",
          border: "none",
          borderRadius: 6,
          cursor: "pointer"
        }}
      >
        Logout
      </button>
    </div>
  );
}