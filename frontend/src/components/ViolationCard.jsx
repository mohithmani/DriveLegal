function ViolationCard({ data }) {
  if (!data) return null;

  const severityConfig = {
    High: {
      bg: "rgba(239,68,68,0.12)",
      border: "rgba(239,68,68,0.45)",
      badge: "rgba(239,68,68,0.18)",
      text: "#fca5a5",
      dot: "#ef4444",
    },
    Medium: {
      bg: "rgba(245,158,11,0.10)",
      border: "rgba(245,158,11,0.40)",
      badge: "rgba(245,158,11,0.18)",
      text: "#fcd34d",
      dot: "#f59e0b",
    },
    Low: {
      bg: "rgba(52,211,153,0.09)",
      border: "rgba(52,211,153,0.38)",
      badge: "rgba(52,211,153,0.16)",
      text: "#6ee7b7",
      dot: "#34d399",
    },
  };

  const s = severityConfig[data.severity] || severityConfig["Medium"];

  // SAFE VALUE HANDLER (FIX CRASH ISSUES)
  const safe = (value) => (value && value !== "" ? value : "Not Available");

  return (
    <div
      style={{
        marginTop: "20px",
        borderRadius: "18px",
        overflow: "hidden",
        border: `1px solid ${s.border}`,
        background:
          "linear-gradient(160deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0.02) 100%)",
        backdropFilter: "blur(14px)",
        boxShadow: `0 0 28px ${s.border}, inset 0 0 0 1px rgba(255,255,255,0.04)`,
        color: "white",
        fontFamily: "inherit",
      }}
    >
      {/* Top accent bar */}
      <div
        style={{
          height: 4,
          background: `linear-gradient(90deg, ${s.dot}, transparent)`,
        }}
      />

      {/* Header */}
      <div
        style={{
          padding: "16px 20px 14px",
          borderBottom: `1px solid rgba(255,255,255,0.07)`,
          display: "flex",
          alignItems: "center",
          gap: 12,
          background: s.bg,
        }}
      >
        <div
          style={{
            width: 44,
            height: 44,
            borderRadius: 12,
            background: "rgba(239,68,68,0.2)",
            border: "1px solid rgba(239,68,68,0.35)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            fontSize: "1.5rem",
            flexShrink: 0,
            boxShadow: "0 0 12px rgba(239,68,68,0.3)",
          }}
        >
          🚨
        </div>

        <h3
          style={{
            margin: 0,
            fontSize: "1.05rem",
            fontWeight: 700,
            background: "linear-gradient(90deg, #ffffff, #fca5a5)",
            WebkitBackgroundClip: "text",
            WebkitTextFillColor: "transparent",
            lineHeight: 1.3,
          }}
        >
          {safe(data.offence_name)}
        </h3>
      </div>

      {/* Info grid */}
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "1fr 1fr",
          gap: 8,
          padding: "16px 20px",
        }}
      >
        {[
          { icon: "🗺️", label: "State", value: safe(data.state_name) },
          { icon: "📂", label: "Category", value: safe(data.category) },
          { icon: "⚖️", label: "Section", value: safe(data.section) },
        ].map(({ icon, label, value }) => (
          <div
            key={label}
            style={{
              padding: "10px 12px",
              borderRadius: 10,
              background: "rgba(255,255,255,0.04)",
              border: "1px solid rgba(255,255,255,0.08)",
            }}
          >
            <p
              style={{
                margin: "0 0 3px",
                fontSize: "0.72rem",
                color: "#64748b",
                fontWeight: 600,
                letterSpacing: "0.05em",
                textTransform: "uppercase",
              }}
            >
              {icon} {label}
            </p>
            <p
              style={{
                margin: 0,
                fontSize: "0.9rem",
                color: "#e2e8f0",
                fontWeight: 600,
              }}
            >
              {value}
            </p>
          </div>
        ))}

        {/* Severity */}
        <div
          style={{
            padding: "10px 12px",
            borderRadius: 10,
            background: s.badge,
            border: `1px solid ${s.border}`,
            display: "flex",
            alignItems: "center",
            gap: 8,
          }}
        >
          <div
            style={{
              width: 8,
              height: 8,
              borderRadius: "50%",
              background: s.dot,
              boxShadow: `0 0 6px ${s.dot}`,
            }}
          />
          <div>
            <p
              style={{
                margin: "0 0 2px",
                fontSize: "0.72rem",
                color: "#64748b",
                fontWeight: 600,
                letterSpacing: "0.05em",
                textTransform: "uppercase",
              }}
            >
              ⚡ Severity
            </p>
            <p
              style={{
                margin: 0,
                fontSize: "0.9rem",
                color: s.text,
                fontWeight: 700,
              }}
            >
              {safe(data.severity)}
            </p>
          </div>
        </div>
      </div>

      {/* Fine section */}
      <div
        style={{
          margin: "0 20px 16px",
          borderRadius: 12,
          overflow: "hidden",
          border: "1px solid rgba(239,68,68,0.25)",
        }}
      >
        <div
          style={{
            padding: "12px 16px",
            background:
              "linear-gradient(135deg, rgba(239,68,68,0.15), rgba(239,68,68,0.06))",
            borderBottom: "1px solid rgba(239,68,68,0.18)",
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
          }}
        >
          <span style={{ color: "#94a3b8", fontSize: "0.85rem" }}>💸 Fine</span>
          <span style={{ fontSize: "1.3rem", fontWeight: 800, color: "#f87171" }}>
            ₹{safe(data.first_offence_fine)}
          </span>
        </div>

        <div
          style={{
            padding: "10px 16px",
            background: "rgba(255,255,255,0.03)",
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
          }}
        >
          <span style={{ color: "#64748b", fontSize: "0.82rem" }}>
            🔁 Repeat Fine
          </span>
          <span style={{ fontSize: "1rem", fontWeight: 700, color: "#fca5a5" }}>
            ₹{safe(data.repeat_offence_fine)}
          </span>
        </div>
      </div>

      {/* Description */}
      <div
        style={{
          margin: "0 20px 18px",
          padding: "12px 14px",
          borderRadius: 10,
          background: "rgba(148,163,184,0.06)",
          border: "1px solid rgba(148,163,184,0.12)",
        }}
      >
        <p
          style={{
            margin: 0,
            fontSize: "0.88rem",
            color: "#cbd5e1",
            lineHeight: 1.65,
          }}
        >
          {safe(data.description)}
        </p>
      </div>
    </div>
  );
}

export default ViolationCard;