function ViolationCard({ data }) {
  if (!data) return null;

  return (
    <div
      style={{
        marginTop: "20px",
        padding: "15px",
        border: "2px solid red",
        borderRadius: "10px",
        background: "#fff1f2",
      }}
    >
      <h3>🚨 {data.offence_name}</h3>

      <p><b>State:</b> {data.state_name}</p>
      <p><b>Category:</b> {data.category}</p>
      <p><b>Section:</b> {data.section}</p>
      <p><b>Severity:</b> {data.severity}</p>

      <p style={{ color: "red", fontWeight: "bold" }}>
        Fine: ₹{data.first_offence_fine}
      </p>

      <p>Repeat Fine: ₹{data.repeat_offence_fine}</p>

      <p>{data.description}</p>
    </div>
  );
}

export default ViolationCard;