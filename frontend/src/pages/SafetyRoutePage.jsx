import { useEffect, useState } from "react";
import Fuse from "fuse.js";
import SafetyRouteMap from "../components/Map/SafetyRouteMap";

export default function SafetyRoutePage() {
  const [currentLocation, setCurrentLocation] =
    useState(null);

  const [destinationText, setDestinationText] =
    useState("");

  const [destination, setDestination] =
    useState(null);

  const [loading, setLoading] =
    useState(false);

  const [routeInfo, setRouteInfo] =
    useState(null);

  const [correctedPlace, setCorrectedPlace] =
    useState("");

  /* ================= AI PLACE DATABASE ================= */
  const commonPlaces = [
    "Chennai",
    "Coimbatore",
    "Madurai",
    "Salem",
    "Trichy",
    "Erode",
    "Tiruppur",
    "Bangalore",
    "Bengaluru",
    "Mysore",
    "Hyderabad",
    "Mumbai",
    "Delhi",
    "Pune",
    "Kolkata",
    "Ahmedabad",
    "Airport",
    "Hospital",
    "Mall",
    "Bus Stand",
    "Railway Station",
    "College",
    "School",
    "Temple",
  ];

  const fuse = new Fuse(commonPlaces, {
    threshold: 0.45,
    includeScore: true,
  });

  /* ================= GET LIVE LOCATION ================= */
  useEffect(() => {
    if (!navigator.geolocation) {
      alert("Geolocation not supported");
      return;
    }

    navigator.geolocation.getCurrentPosition(
      (position) => {
        setCurrentLocation({
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        });
      },
      (error) => {
        console.error(
          "Location error:",
          error
        );

        alert(
          "Please allow location access."
        );
      },
      {
        enableHighAccuracy: true,
      }
    );
  }, []);

  /* ================= SMART AI SEARCH ================= */
  const handleSearch = async () => {
    if (!destinationText.trim()) {
      alert("Enter destination");
      return;
    }

    try {
      setLoading(true);
      setRouteInfo(null);

      let searchQuery =
        destinationText.trim();

      /* AI SPELL CORRECTION */
      const fuzzyResult =
        fuse.search(searchQuery);

      if (fuzzyResult.length > 0) {
        searchQuery =
          fuzzyResult[0].item;
      }

      /* SEARCH LOCATION */
      const response = await fetch(
        `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(
          searchQuery
        )}&addressdetails=1&limit=5`
      );

      const data =
        await response.json();

      if (!data.length) {
        alert(
          "Location not found"
        );
        return;
      }

      const bestPlace = data[0];

      setDestination({
        lat: parseFloat(bestPlace.lat),
        lng: parseFloat(bestPlace.lon),
        address:
          bestPlace.display_name,
      });

      setCorrectedPlace(
        bestPlace.display_name
      );
    } catch (err) {
      console.error(
        "Search error:",
        err
      );

      alert(
        "Failed to search location."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      style={{
        background: "#0a0c10",
        minHeight: "100vh",
        padding: 15,
        color: "white",
      }}
    >
      <h2
        style={{
          marginBottom: 15,
        }}
      >
        🛣️ Safety Route
      </h2>

      {/* SEARCH BAR */}
      <div
        style={{
          display: "flex",
          gap: 10,
          marginBottom: 15,
        }}
      >
        <input
          type="text"
          placeholder="Try: chennaii, banglore, airprt..."
          value={destinationText}
          onChange={(e) =>
            setDestinationText(
              e.target.value
            )
          }
          onKeyDown={(e) => {
            if (
              e.key === "Enter"
            ) {
              handleSearch();
            }
          }}
          style={{
            flex: 1,
            padding: 12,
            borderRadius: 10,
            border:
              "1px solid #333",
            background:
              "#11151c",
            color: "white",
            fontSize: 16,
            outline: "none",
          }}
        />

        <button
          onClick={handleSearch}
          disabled={loading}
          style={{
            padding:
              "12px 20px",
            borderRadius: 10,
            border: "none",
            background:
              "#2196F3",
            color: "white",
            cursor: "pointer",
            fontWeight: "bold",
            minWidth: 130,
          }}
        >
          {loading
            ? "Searching..."
            : "Find Route"}
        </button>
      </div>

      {/* AI DETECTED LOCATION */}
      {correctedPlace && (
        <div
          style={{
            marginBottom: 15,
            background:
              "#11151c",
            padding: 12,
            borderRadius: 10,
            border:
              "1px solid #222",
          }}
        >
          <b>
            🤖 AI Corrected Location:
          </b>

          <p
            style={{
              color: "#8bc4ff",
              marginTop: 8,
            }}
          >
            {correctedPlace}
          </p>
        </div>
      )}

      <div
        style={{
          display: "flex",
          gap: 15,
          height: "80vh",
        }}
      >
        {/* MAP */}
        <div
          style={{
            flex: 2,
            borderRadius: 15,
            overflow: "hidden",
            border:
              "1px solid #222",
            background:
              "#11151c",
          }}
        >
          <SafetyRouteMap
            currentLocation={
              currentLocation
            }
            destination={
              destination
            }
            setRouteInfo={
              setRouteInfo
            }
          />
        </div>

        {/* ROUTE DETAILS */}
        <div
          style={{
            flex: 1,
            background:
              "#11151c",
            borderRadius: 15,
            padding: 20,
            border:
              "1px solid #222",
            overflowY: "auto",
          }}
        >
          <h3>
            📍 Route Details
          </h3>

          {!routeInfo ? (
            <p
              style={{
                color: "#aaa",
              }}
            >
              Search a destination
              to see route details.
            </p>
          ) : (
            <>
              <p>
                🚗 Distance:{" "}
                {
                  routeInfo.distance
                }
              </p>

              <p>
                ⏱ Travel Time:{" "}
                {
                  routeInfo.time
                }
              </p>

              <p>
                🚦 Traffic:{" "}
                {
                  routeInfo.traffic
                }
              </p>

              <p>
                🛣 Road Name:{" "}
                {
                  routeInfo.roadName
                }
              </p>

              <p>
                🏙 Road Type:{" "}
                {
                  routeInfo.roadType
                }
              </p>

              <p>
                📌 Destination:
                <br />
                {
                  destination?.address
                }
              </p>

              <div
                style={{
                  marginTop: 25,
                  padding: 15,
                  borderRadius: 12,
                  background:
                    "#0d1724",
                  border:
                    "1px solid #1e3a5f",
                }}
              >
                <h4>
                  🤖 AI Safety
                  Analysis
                </h4>

                <p>
                  ✅ Safest route
                  selected
                </p>

                <p>
                  🚦 Traffic:{" "}
                  {
                    routeInfo.traffic
                  }
                </p>

                <p>
                  ⚠️ Drive
                  carefully in
                  busy areas
                </p>

                <p>
                  🛣 Prefer
                  highways for
                  long travel
                </p>

                <p>
                  🪖 Wear helmet /
                  seat belt
                </p>
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
}