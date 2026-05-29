import { useEffect, useRef } from "react";
import {
  MapContainer,
  TileLayer,
  useMap,
  Marker,
  Popup,
} from "react-leaflet";

import L from "leaflet";

import "leaflet/dist/leaflet.css";
import "leaflet-routing-machine";
import "leaflet-routing-machine/dist/leaflet-routing-machine.css";

/* ================= FIX LEAFLET ICON ISSUE ================= */
delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
  iconRetinaUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",

  iconUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",

  shadowUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
});

/* ================= ROUTING COMPONENT ================= */
function Routing({
  currentLocation,
  destination,
  setRouteInfo,
}) {
  const map = useMap();
  const routingControlRef = useRef(null);

  useEffect(() => {
    if (
      !currentLocation ||
      !destination ||
      !L.Routing
    )
      return;

    // Remove previous route
    if (routingControlRef.current) {
      map.removeControl(
        routingControlRef.current
      );
    }

    const routingControl =
      L.Routing.control({
        waypoints: [
          L.latLng(
            currentLocation.lat,
            currentLocation.lng
          ),

          L.latLng(
            destination.lat,
            destination.lng
          ),
        ],

        routeWhileDragging: false,
        addWaypoints: false,
        draggableWaypoints: false,
        fitSelectedRoutes: true,
        show: false,

        lineOptions: {
          styles: [
            {
              color: "blue",
              weight: 6,
            },
          ],
        },

        createMarker: (
          index,
          waypoint
        ) => {
          return L.marker(
            waypoint.latLng
          ).bindPopup(
            index === 0
              ? "📍 Current Location"
              : "🎯 Destination"
          );
        },
      });

    /* ================= ROUTE INFO ================= */
    routingControl.on(
      "routesfound",
      function (e) {
        const route =
          e.routes?.[0];

        if (!route) return;

        const distance =
          (
            route.summary
              .totalDistance / 1000
          ).toFixed(2);

        const time =
          Math.round(
            route.summary
              .totalTime / 60
          );

        /* Traffic estimate */
        let traffic =
          "🟢 Low";

        if (time > 20) {
          traffic =
            "🟡 Moderate";
        }

        if (time > 40) {
          traffic =
            "🔴 Heavy";
        }

        /* Road Name */
        let roadName =
          "Local Road";

        const firstInstruction =
          route.instructions?.[0];

        if (
          firstInstruction?.road
        ) {
          roadName =
            firstInstruction.road;
        }

        /* Road Type */
        let roadType =
          "City Road";

        if (
          roadName
            .toUpperCase()
            .includes("NH")
        ) {
          roadType =
            "National Highway";
        }

        if (setRouteInfo) {
          setRouteInfo({
            distance:
              distance + " km",

            time:
              time + " mins",

            traffic,

            roadName,

            roadType,
          });
        }
      }
    );

    routingControl.addTo(map);

    routingControlRef.current =
      routingControl;

    return () => {
      if (
        routingControlRef.current
      ) {
        map.removeControl(
          routingControlRef.current
        );
      }
    };
  }, [
    map,
    currentLocation,
    destination,
    setRouteInfo,
  ]);

  return null;
}

/* ================= MAIN COMPONENT ================= */
export default function SafetyRouteMap({
  currentLocation,
  destination,
  setRouteInfo,
}) {
  const center =
    currentLocation
      ? [
          currentLocation.lat,
          currentLocation.lng,
        ]
      : [11.0168, 76.9558];

  return (
    <MapContainer
      center={center}
      zoom={13}
      style={{
        height: "100%",
        width: "100%",
        borderRadius: "15px",
      }}
    >
      <TileLayer
        attribution="© OpenStreetMap"
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />

      {/* Current Location Marker */}
      {currentLocation && (
        <Marker
          position={[
            currentLocation.lat,
            currentLocation.lng,
          ]}
        >
          <Popup>
            📍 Current Location
          </Popup>
        </Marker>
      )}

      {/* Destination Marker */}
      {destination && (
        <Marker
          position={[
            destination.lat,
            destination.lng,
          ]}
        >
          <Popup>
            🎯 Destination
          </Popup>
        </Marker>
      )}

      {/* Route */}
      {currentLocation &&
        destination && (
          <Routing
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
        )}
    </MapContainer>
  );
}