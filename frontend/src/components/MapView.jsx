import { useEffect, useState } from "react";
import {
  MapContainer,
  TileLayer,
  Marker,
  Popup,
  Circle,
  useMap,
} from "react-leaflet";

import "leaflet/dist/leaflet.css";
import L from "leaflet";

// Fix Leaflet marker icon issue
delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
  iconRetinaUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",
  iconUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
  shadowUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
});

// Auto move map to current location
function ChangeMapView({ center }) {
  const map = useMap();

  useEffect(() => {
    if (center) {
      map.flyTo(center, 18, {
        duration: 1.5,
      });
    }
  }, [center, map]);

  return null;
}

function MapView() {
  const [position, setPosition] = useState(null);
  const [accuracy, setAccuracy] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!navigator.geolocation) {
      setError("Geolocation not supported");
      setLoading(false);
      return;
    }

    // Get fresh location first
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        const {
          latitude,
          longitude,
          accuracy,
        } = pos.coords;

        console.log(
          "Initial GPS:",
          latitude,
          longitude
        );

        setPosition([
          latitude,
          longitude,
        ]);

        setAccuracy(
          Math.round(accuracy)
        );

        setLoading(false);
      },

      (err) => {
        console.error(
          "GPS Error:",
          err
        );

        setError(err.message);
        setLoading(false);
      },

      {
        enableHighAccuracy: true,
        timeout: 30000,
        maximumAge: 0,
      }
    );

    // Live tracking
    const watchId =
      navigator.geolocation.watchPosition(
        (pos) => {
          const {
            latitude,
            longitude,
            accuracy,
          } = pos.coords;

          console.log(
            "Live GPS:",
            latitude,
            longitude
          );

          console.log(
            "Accuracy:",
            accuracy,
            "meters"
          );

          setPosition([
            latitude,
            longitude,
          ]);

          setAccuracy(
            Math.round(accuracy)
          );
        },

        (err) => {
          console.error(
            "GPS Watch Error:",
            err
          );

          setError(err.message);
        },

        {
          enableHighAccuracy: true,
          timeout: 30000,
          maximumAge: 0,
        }
      );

    return () => {
      navigator.geolocation.clearWatch(
        watchId
      );
    };
  }, []);

  if (loading) {
    return (
      <div>
        <h2>
          📍 Detecting your exact location...
        </h2>
        <p>
          Please allow browser
          location permission.
        </p>
      </div>
    );
  }

  if (error) {
    return (
      <div>
        <h2>❌ GPS Error</h2>
        <p>{error}</p>

        <p>
          Check browser location
          permission and Windows
          location settings.
        </p>
      </div>
    );
  }

  if (!position) {
    return <p>Location unavailable.</p>;
  }

  return (
    <div>
      <h2>
        📍 Your Live Location
      </h2>

      <MapContainer
        center={position}
        zoom={18}
        style={{
          height: "450px",
          width: "100%",
          borderRadius: "12px",
        }}
      >
        {/* OpenStreetMap */}
        <TileLayer
          attribution="&copy; OpenStreetMap contributors"
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        {/* Auto move */}
        <ChangeMapView
          center={position}
        />

        {/* Marker */}
        <Marker
          position={position}
        >
          <Popup>
            📍 You are here
            <br />
            Latitude:
            <br />
            {position[0]}
            <br />
            <br />
            Longitude:
            <br />
            {position[1]}
            <br />
            <br />
            Accuracy:
            <br />
            {accuracy} meters
          </Popup>
        </Marker>

        {/* Accuracy circle */}
        {accuracy && (
          <Circle
            center={position}
            radius={accuracy}
          />
        )}
      </MapContainer>

      <br />

      <p>
        <strong>
          Latitude:
        </strong>{" "}
        {position[0]}
      </p>

      <p>
        <strong>
          Longitude:
        </strong>{" "}
        {position[1]}
      </p>

      <p>
        <strong>
          GPS Accuracy:
        </strong>{" "}
        {accuracy} meters
      </p>

      {accuracy > 100 && (
        <p>
          ⚠️ GPS is not very
          accurate. Try enabling
          Wi-Fi and Location
          Services.
        </p>
      )}
    </div>
  );
}

export default MapView;