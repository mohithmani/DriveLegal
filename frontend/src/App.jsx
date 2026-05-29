import { Routes, Route } from "react-router-dom";

import Home from "./pages/Home";
import MapPage from "./pages/MapPage";
import ChatPage from "./pages/ChatPage";
import ViolationsPage from "./pages/ViolationsPage";
import QuizPage from "./pages/QuizPage";
import SafetyRoutePage from "./pages/SafetyRoutePage";

function App() {
  return (
    <Routes>
      {/* HOME PAGE */}
      <Route path="/" element={<Home />} />

      {/* MAP PAGE */}
      <Route path="/map" element={<MapPage />} />

      {/* CHAT PAGE */}
      <Route path="/chat" element={<ChatPage />} />

      {/* VIOLATIONS PAGE */}
      <Route path="/violations" element={<ViolationsPage />} />

      {/* QUIZ PAGE */}
      <Route path="/quiz" element={<QuizPage />} />

      {/* SAFETY ROUTE PAGE */}
      <Route path="/safety-route" element={<SafetyRoutePage />} />

      {/* 404 PAGE */}
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}

/* ================= 404 PAGE ================= */

function NotFound() {
  return (
    <div style={styles.notFound}>
      <div>
        <h1 style={{ fontSize: "60px", marginBottom: "10px" }}>404</h1>
        <p style={{ fontSize: "18px", color: "#aaa" }}>Page Not Found</p>
      </div>
    </div>
  );
}

const styles = {
  notFound: {
    height: "100vh",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "#0a0c10",
    color: "#fff",
    fontFamily: "Arial",
    textAlign: "center",
  },
};

export default App;