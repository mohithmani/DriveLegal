import { useNavigate } from "react-router-dom";

export default function Layout({ children }) {
  const navigate = useNavigate();

  return (
    <div className="flex min-h-screen bg-gray-950 text-white">

      {/* SIDEBAR */}
      <div className="w-64 bg-gray-900 p-5 hidden md:block">
        <h1 className="text-2xl font-bold mb-6">🚗 DriveLegal</h1>

        <div className="space-y-3">
          <button onClick={() => navigate("/")} className="block w-full text-left hover:text-blue-400">
            Home
          </button>

          <button onClick={() => navigate("/map")} className="block w-full text-left hover:text-blue-400">
            Map
          </button>

          <button onClick={() => navigate("/chat")} className="block w-full text-left hover:text-blue-400">
            Chat
          </button>

          <button onClick={() => navigate("/quiz")} className="block w-full text-left hover:text-blue-400">
            Quiz
          </button>
        </div>
      </div>

      {/* MAIN CONTENT */}
      <div className="flex-1 p-6">
        {children}
      </div>
    </div>
  );
}