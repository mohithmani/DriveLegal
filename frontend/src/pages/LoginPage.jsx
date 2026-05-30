
import { useState } from "react";
import { supabase } from "../supabaseClient";
import { useNavigate } from "react-router-dom";

export default function LoginPage() {
  const navigate = useNavigate();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  // 🔐 SIGN UP
  const signUp = async () => {
    if (!email || !password) {
      alert("Please enter email and password");
      return;
    }

    setLoading(true);

    const { error } = await supabase.auth.signUp({
      email,
      password,
    });

    setLoading(false);

    if (error) {
      alert(error.message);
      return;
    }

    alert("Account created successfully 🚀");
  };

  // 🔐 LOGIN
  const login = async () => {
    if (!email || !password) {
      alert("Please enter email and password");
      return;
    }

    setLoading(true);

    const { error } =
      await supabase.auth.signInWithPassword({
        email,
        password,
      });

    setLoading(false);

    if (error) {
      alert(error.message);
      return;
    }

    alert("Login successful 🚀");
    navigate("/");
  };

  // 🔵 GOOGLE LOGIN
  const googleLogin = async () => {
    const { error } =
      await supabase.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo:
            "http://localhost:5173",
        },
      });

    if (error) {
      alert(error.message);
    }
  };

  return (
    <div style={styles.container}>
      <div style={styles.card}>
        <h2 style={styles.title}>
          🚗 DriveLegal Login
        </h2>

        <input
          placeholder="Email"
          type="email"
          value={email}
          onChange={(e) =>
            setEmail(e.target.value)
          }
          style={styles.input}
        />

        <input
          placeholder="Password"
          type="password"
          value={password}
          onChange={(e) =>
            setPassword(e.target.value)
          }
          style={styles.input}
        />

        <button
          onClick={login}
          style={styles.loginBtn}
          disabled={loading}
        >
          {loading
            ? "Loading..."
            : "Login"}
        </button>

        <button
          onClick={signUp}
          style={styles.signupBtn}
          disabled={loading}
        >
          {loading
            ? "Loading..."
            : "Sign Up"}
        </button>

        {/* Google Login */}
        <button
          onClick={googleLogin}
          style={styles.googleBtn}
        >
          Continue with Google
        </button>
      </div>
    </div>
  );
}

/* ================= STYLES ================= */

const styles = {
  container: {
    height: "100vh",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "#0a0c10",
    color: "#fff",
  },

  card: {
    width: "320px",
    padding: "25px",
    borderRadius: "12px",
    background: "#13161e",
    boxShadow:
      "0 4px 12px rgba(0,0,0,0.4)",
    textAlign: "center",
  },

  title: {
    marginBottom: "20px",
  },

  input: {
    width: "100%",
    padding: "10px",
    marginBottom: "12px",
    borderRadius: "6px",
    border: "none",
    outline: "none",
    boxSizing: "border-box",
  },

  loginBtn: {
    width: "100%",
    padding: "10px",
    background: "#4f7cff",
    color: "#fff",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
  },

  signupBtn: {
    width: "100%",
    padding: "10px",
    marginTop: "10px",
    background: "#2ecc71",
    color: "#fff",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
  },

  googleBtn: {
    width: "100%",
    padding: "10px",
    marginTop: "10px",
    background: "#fff",
    color: "#000",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
    fontWeight: "bold",
  },
};

