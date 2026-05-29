import { useEffect, useState } from "react";
import LocationMap from "../components/Map/LocationMap";

export default function MapPage() {
  const [location, setLocation] = useState(null);
  const [loading, setLoading] = useState(true);

  /* ================= GET LOCATION DETAILS ================= */
  useEffect(() => {
    getLocationDetails();
  }, []);

  const getLocationDetails = () => {
    if (!navigator.geolocation) {
      alert("Geolocation is not supported");
      return;
    }

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
  };

  return (
    <div
      style={{
        background: "#0a0c10",
        minHeight: "100vh",
        padding: 15,
      }}
    >
      <h2
        style={{
          color: "white",
          marginBottom: 15,
        }}
      >
        📍 Live Map
      </h2>

      <div
        style={{
          display: "flex",
          gap: 15,
          height: "85vh",
        }}
      >
        {/* MAP SECTION */}
        <div
          style={{
            flex: 2,
            borderRadius: 15,
            overflow: "hidden",
            border: "1px solid #222",
          }}
        >
          <LocationMap />
        </div>

        {/* SIDE INFO PANEL */}
        <div
          style={{
            flex: 1,
            background: "#11151c",
            borderRadius: 15,
            padding: 20,
            color: "white",
            border: "1px solid #222",
            overflowY: "auto",
          }}
        >
          <h3 style={{ marginBottom: 20 }}>
            📍 Your Location
          </h3>

          {loading ? (
            <p style={{ color: "#aaa" }}>
              Getting location...
            </p>
          ) : location ? (
            <div style={{ lineHeight: 2 }}>
              <p>
                <strong>Latitude:</strong>{" "}
                {location.latitude.toFixed(6)}
              </p>

              <p>
                <strong>Longitude:</strong>{" "}
                {location.longitude.toFixed(6)}
              </p>

              <p>
                <strong>City:</strong>{" "}
                {location.city}
              </p>

              <p>
                <strong>State:</strong>{" "}
                {location.state}
              </p>

              <p>
                <strong>Country:</strong>{" "}
                {location.country}
              </p>

              <p>
                <strong>Full Address:</strong>
                <br />
                <span style={{ color: "#ddd" }}>
                  {location.address}
                </span>
              </p>
            </div>
          ) : (
            <p style={{ color: "#ff6666" }}>
              Failed to fetch location
            </p>
          )}
        </div>
      </div>
    </div>
  );
}