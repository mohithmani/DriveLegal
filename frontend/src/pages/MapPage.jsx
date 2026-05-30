import { useEffect, useState, useCallback } from "react";
import LocationMap from "../components/Map/LocationMap";

export default function MapPage() {
  const [location, setLocation] = useState(null);
  const [loading, setLoading] = useState(true);

  /* ================= GET LOCATION ================= */
  const getLocationDetails = useCallback(() => {
    if (!navigator.geolocation) {
      alert("Geolocation is not supported");
      setLoading(false);
      return;
    }

    setLoading(true);

    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const lat = position.coords.latitude;
        const lon = position.coords.longitude;

        try {
          const response = await fetch(
            `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}`
          );

          const data = await response.json();

          setLocation({
            latitude: lat,
            longitude: lon,
            city:
              data.address?.city ||
              data.address?.town ||
              data.address?.village ||
              "Unknown",
            state: data.address?.state || "Unknown",
            country: data.address?.country || "Unknown",
            address: data.display_name || "Not found",
          });
        } catch (err) {
          console.error("Location fetch error:", err);
        }

        setLoading(false);
      },
      (err) => {
        console.error(err);
        alert("Location permission denied");
        setLoading(false);
      }
    );
  }, []);

  useEffect(() => {
    getLocationDetails();
  }, [getLocationDetails]);

  const infoRows = location
    ? [
        { label: "🌐 Latitude", value: location.latitude.toFixed(6), color: "#7dd3fc" },
        { label: "🌐 Longitude", value: location.longitude.toFixed(6), color: "#7dd3fc" },
        { label: "🏙️ City", value: location.city, color: "#a78bfa" },
        { label: "🗺️ State", value: location.state, color: "#a78bfa" },
        { label: "🌍 Country", value: location.country, color: "#34d399" },
      ]
    : [];

  return (
    <div
      style={{
        background: "radial-gradient(ellipse at 30% 0%, #0d1b2a 0%, #0f0c29 40%, #0a0a18 100%)",
        minHeight: "100vh",
        padding: 15,
        position: "relative",
        overflow: "hidden",
      }}
    >
      {/* Background blobs (UNCHANGED) */}
      <div
        style={{
          position: "fixed",
          top: "-80px",
          left: "-80px",
          width: "340px",
          height: "340px",
          borderRadius: "50%",
          pointerEvents: "none",
          zIndex: 0,
          background: "radial-gradient(circle, rgba(99,102,241,0.18) 0%, transparent 70%)",
        }}
      />

      <div
        style={{
          position: "fixed",
          bottom: "-60px",
          right: "-60px",
          width: "280px",
          height: "280px",
          borderRadius: "50%",
          pointerEvents: "none",
          zIndex: 0,
          background: "radial-gradient(circle, rgba(52,211,153,0.14) 0%, transparent 70%)",
        }}
      />

      {/* HEADER */}
      <h2
        style={{
          marginBottom: 15,
          fontSize: "1.6rem",
          fontWeight: 700,
          position: "relative",
          zIndex: 1,
          display: "inline-flex",
          alignItems: "center",
          gap: 10,
          background: "linear-gradient(90deg, #60a5fa, #a78bfa, #34d399)",
          WebkitBackgroundClip: "text",
          WebkitTextFillColor: "transparent",
        }}
      >
        📍 Live Map
      </h2>

      {/* MAIN LAYOUT */}
      <div
        style={{
          display: "flex",
          gap: 15,
          height: "85vh",
          position: "relative",
          zIndex: 1,
        }}
      >
        {/* MAP */}
        <div
          style={{
            flex: 2,
            borderRadius: 15,
            overflow: "hidden",
            border: "1px solid rgba(99,102,241,0.35)",
            boxShadow:
              "0 0 32px rgba(99,102,241,0.18), inset 0 0 0 1px rgba(255,255,255,0.04)",
          }}
        >
          <LocationMap />
        </div>

        {/* SIDE PANEL */}
        <div
          style={{
            flex: 1,
            borderRadius: 15,
            padding: 20,
            color: "white",
            overflowY: "auto",
            background:
              "linear-gradient(160deg, rgba(255,255,255,0.06) 0%, rgba(255,255,255,0.02) 100%)",
            border: "1px solid rgba(139,92,246,0.3)",
            backdropFilter: "blur(14px)",
          }}
        >
          <div style={{ marginBottom: 20, display: "flex", alignItems: "center", gap: 10 }}>
            <div
              style={{
                width: 38,
                height: 38,
                borderRadius: 10,
                background: "linear-gradient(135deg, #6366f1, #8b5cf6)",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              📍
            </div>
            <h3 style={{ margin: 0 }}>Your Location</h3>
          </div>

          {loading ? (
            <p>Getting location...</p>
          ) : location ? (
            <>
              {infoRows.map((item) => (
                <div
                  key={item.label}
                  style={{
                    display: "flex",
                    justifyContent: "space-between",
                    padding: 8,
                    marginBottom: 6,
                  }}
                >
                  <span>{item.label}</span>
                  <span style={{ color: item.color }}>{item.value}</span>
                </div>
              ))}

              <button
                onClick={getLocationDetails}
                style={{
                  marginTop: 18,
                  width: "100%",
                  padding: 10,
                  borderRadius: 10,
                  border: "none",
                  cursor: "pointer",
                  background: "linear-gradient(135deg, #6366f1, #8b5cf6)",
                  color: "white",
                }}
              >
                🔄 Refresh Location
              </button>
            </>
          ) : (
            <p>⚠️ Failed to fetch location</p>
          )}
        </div>
      </div>
    </div>
  );
}