import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "../supabaseClient";

export default function Home() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);

  // ✅ FIXED: cleaner Supabase auth check
  useEffect(() => {
    const getUser = async () => {
      const { data } = await supabase.auth.getUser();
      setUser(data?.user || null);
    };

    getUser();
  }, []);

  // logout
  const handleLogout = async () => {
    await supabase.auth.signOut();
    setUser(null);
    navigate("/");
  };

  const cards = [
    {
      emoji: "📍",
      title: "Live Map",
      desc: "Track GPS location",
      route: "/map",
      gradient: "from-blue-500/20 to-cyan-500/20",
      badge: "bg-blue-500/20 text-blue-300",
    },
    {
      emoji: "💬",
      title: "AI Chat",
      desc: "Ask traffic law questions",
      route: "/chat",
      gradient: "from-violet-500/20 to-purple-500/20",
      badge: "bg-violet-500/20 text-violet-300",
    },
    {
      emoji: "🚨",
      title: "Violations",
      desc: "Traffic rule database",
      route: "/violations",
      gradient: "from-red-500/20 to-rose-500/20",
      badge: "bg-red-500/20 text-red-300",
    },
    {
      emoji: "🧠",
      title: "Quiz",
      desc: "Test your knowledge",
      route: "/quiz",
      gradient: "from-amber-500/20 to-yellow-500/20",
      badge: "bg-amber-500/20 text-amber-300",
    },
    {
      emoji: "🛣️",
      title: "Safety Route",
      desc: "Find safest path",
      route: "/safety-route",
      gradient: "from-emerald-500/20 to-teal-500/20",
      badge: "bg-emerald-500/20 text-emerald-300",
    },
  ];

  return (
    <div
      className="min-h-screen text-white flex flex-col"
      style={{
        background:
          "radial-gradient(ellipse at 20% 20%, #0f0c29 0%, #302b63 40%, #24243e 70%, #0a0a1a 100%)",
      }}
    >
      {/* HEADER */}
      <header className="w-full p-5 flex justify-between items-center">
        <h1 className="text-2xl font-bold">🚗 DriveLegal AI</h1>

        <div className="flex items-center gap-3">
          {!user ? (
            <button
              onClick={() => navigate("/login")}
              className="px-5 py-2 rounded-xl"
              style={{ background: "#6366f1", color: "white" }}
            >
              Login / Signup
            </button>
          ) : (
            <>
              <span>{user.email}</span>
              <button
                onClick={handleLogout}
                className="px-4 py-2 rounded-xl"
                style={{ background: "red", color: "white" }}
              >
                Logout
              </button>
            </>
          )}
        </div>
      </header>

      {/* HERO */}
      <section className="text-center py-10">
        <h2 className="text-3xl font-bold">
          Smart Traffic Law Assistant
        </h2>
        <p>AI-powered driving rules & safety system</p>
      </section>

      {/* CARDS */}
      <main className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 px-6 pb-10">
        {cards.map((card) => (
          <div
            key={card.route}
            onClick={() => navigate(card.route)}
            className="p-5 rounded-xl cursor-pointer"
            style={{
              background: "rgba(255,255,255,0.05)",
              border: "1px solid rgba(255,255,255,0.1)",
            }}
          >
            <div className="text-3xl">{card.emoji}</div>
            <h3 className="text-xl font-bold">{card.title}</h3>
            <p>{card.desc}</p>
          </div>
        ))}
      </main>

      {/* FOOTER */}
      <footer className="text-center p-5 text-sm opacity-70">
        🚗 DriveLegal AI © 2026
      </footer>
    </div>
  );
}