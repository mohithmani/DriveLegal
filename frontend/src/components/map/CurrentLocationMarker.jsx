import React, {
  useEffect,
} from "react";

import {
  Marker,
  Popup,
  useMap,
  Circle,
} from "react-leaflet";

export default function CurrentLocationMarker({
  coordinates,
}) {
  const map = useMap();

  useEffect(() => {
    if (coordinates) {
      // Smoothly move map
      map.flyTo(
        [
          coordinates.lat,
          coordinates.lng,
        ],
        17,
        {
          animate: true,
          duration: 1.5,
        }
      );
    }
  }, [coordinates, map]);

  // Prevent crash
  if (!coordinates)
    return null;

  return (
    <>
      {/* Marker */}
      <Marker
        position={[
          coordinates.lat,
          coordinates.lng,
        ]}
      >
        <Popup>
          <div className="p-1 text-center">
            <p className="font-semibold text-slate-900 text-sm">
              📍 You Are Here
            </p>

            <p className="text-xs text-slate-500 mt-1">
              GPS tracking active
            </p>

            <p className="text-xs mt-2">
              Latitude:
              <br />
              {
                coordinates.lat
              }
            </p>

            <p className="text-xs">
              Longitude:
              <br />
              {
                coordinates.lng
              }
            </p>

            <p className="text-xs mt-2">
              Accuracy:
              {" "}
              {Math.round(
                coordinates.accuracy
              )}
              m
            </p>
          </div>
        </Popup>
      </Marker>

      {/* GPS accuracy circle */}
      <Circle
        center={[
          coordinates.lat,
          coordinates.lng,
        ]}
        radius={
          coordinates.accuracy ||
          50
        }
      />
    </>
  );
}