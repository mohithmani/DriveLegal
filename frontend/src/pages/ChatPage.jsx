import ChatBox from "../components/ChatBox";

export default function ChatPage() {
  return (
    <div style={{ padding: 10, background: "#0a0c10", minHeight: "100vh" }}>
      <h2 style={{ color: "white" }}>💬 AI Chat Assistant</h2>

      <ChatBox />
    </div>
  );
}