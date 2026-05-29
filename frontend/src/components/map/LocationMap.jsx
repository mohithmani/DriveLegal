
import React from "react";
import {
  MapContainer,
  TileLayer,
  ZoomControl,
} from "react-leaflet";

import L from "leaflet";
import "leaflet/dist/leaflet.css";

import { useGeolocation } from "../../hooks/useGeolocation";
import CurrentLocationMarker from "./CurrentLocationMarker";
import SafetyZones from "./SafetyZones";

import icon from "leaflet/dist/images/marker-icon.png";
import iconShadow from "leaflet/dist/images/marker-shadow.png";

// Fix Leaflet marker icon issue
const DefaultIcon = L.icon({
  iconUrl: icon,
  shadowUrl: iconShadow,
  iconSize: [25, 41],
  iconAnchor: [12, 41],
});

L.Marker.prototype.options.icon =
  DefaultIcon;

export default function LocationMap() {
  const {
    coordinates,
    loading,
    error,
  } = useGeolocation();

  // India fallback location
  const defaultCenter = [
    20.5937,
    78.9629,
  ];

  const initialCenter =
    coordinates
      ? [
          coordinates.lat,
          coordinates.lng,
        ]
      : defaultCenter;

  // Loading UI
  if (loading) {
    return (
      <div
        style={{
          height: "650px",
          width: "100%",
          display: "flex",
          justifyContent:
            "center",
          alignItems:
            "center",
          border:
            "1px solid #ddd",
          borderRadius:
            "18px",
          background:
            "#f8fafc",
          fontSize: "18px",
        }}
      >
        📍 Getting live GPS
        location...
      </div>
    );
  }

  // Error UI
  if (error) {
    return (
      <div
        style={{
          height: "650px",
          width: "100%",
          display: "flex",
          justifyContent:
            "center",
          alignItems:
            "center",
          border:
            "1px solid red",
          borderRadius:
            "18px",
          background:
            "#fef2f2",
          color: "red",
          fontSize: "18px",
        }}
      >
        ❌ GPS Error:
        {" "}
        {error}
      </div>
    );
  }

  return (
    <div
      style={{
        width: "100%",
        height: "650px",
        borderRadius:
          "18px",
        overflow:
          "hidden",
        border:
          "1px solid #ddd",
        boxShadow:
          "0 4px 12px rgba(0,0,0,0.12)",
      }}
    >
      <MapContainer
        center={
          initialCenter
        }
        zoom={16}
        zoomControl={false}
        scrollWheelZoom={
          true
        }
        style={{
          width: "100%",
          height: "100%",
        }}
      >
        {/* OpenStreetMap */}
        <TileLayer
          attribution="&copy; OpenStreetMap contributors"
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        {/* Live User Location */}
        <CurrentLocationMarker
          coordinates={
            coordinates
          }
        />

        {/* Future safety zones */}
        <SafetyZones
          userCoordinates={
            coordinates
          }
        />

        {/* Zoom buttons */}
        <ZoomControl position="bottomright" />
      </MapContainer>
    </div>
  );
} 
