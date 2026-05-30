import { useEffect, useState } from "react";
import { Routes, Route } from "react-router-dom";
import { supabase } from "./supabaseClient";

/* ================= PAGES ================= */
import Home from "./pages/Home";
import MapPage from "./pages/MapPage";
import ChatPage from "./pages/ChatPage";
import ViolationsPage from "./pages/ViolationsPage";
import QuizPage from "./pages/QuizPage";
import SafetyRoutePage from "./pages/SafetyRoutePage";
import LoginPage from "./pages/LoginPage"; // ✅ correct ONLY if file is src/LoginPage.jsx

/* ================= APP ================= */
function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const getUser = async () => {
      const { data } = await supabase.auth.getUser();
      setUser(data?.user || null);
      setLoading(false);
    };

    getUser();

    const { data: authListener } =
      supabase.auth.onAuthStateChange((_event, session) => {
        setUser(session?.user || null);
      });

    return () => {
      authListener?.subscription?.unsubscribe();
    };
  }, []);

  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center bg-gray-950 text-white">
        Loading...
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-950 text-white">
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<LoginPage />} />

        <Route path="/map" element={<MapPage />} />
        <Route path="/chat" element={<ChatPage />} />
        <Route path="/violations" element={<ViolationsPage />} />

        <Route
          path="/quiz"
          element={user ? <QuizPage /> : <LoginPage />}
        />

        <Route path="/safety-route" element={<SafetyRoutePage />} />

        <Route path="*" element={<NotFound />} />
      </Routes>
    </div>
  );
}

/* ================= 404 PAGE ================= */
function NotFound() {
  return (
    <div className="h-screen flex flex-col items-center justify-center bg-gray-950 text-white">
      <h1 className="text-6xl font-bold">404</h1>
      <p className="text-gray-400 mt-2">Page Not Found</p>
    </div>
  );
}

export default App;