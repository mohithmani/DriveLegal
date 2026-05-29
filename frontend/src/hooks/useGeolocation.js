import {
  useEffect,
  useState,
} from "react";

export function useGeolocation() {
  const [
    coordinates,
    setCoordinates,
  ] = useState(null);

  const [loading, setLoading] =
    useState(true);

  const [error, setError] =
    useState("");

  useEffect(() => {
    if (
      !navigator.geolocation
    ) {
      setError(
        "Geolocation not supported"
      );

      setLoading(false);
      return;
    }

    // Get fresh GPS
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const {
          latitude,
          longitude,
          accuracy,
        } =
          position.coords;

        setCoordinates({
          lat: latitude,
          lng: longitude,
          accuracy,
        });

        setLoading(false);
      },

      (err) => {
        setError(
          err.message
        );

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
        (position) => {
          const {
            latitude,
            longitude,
            accuracy,
          } =
            position.coords;

          setCoordinates({
            lat: latitude,
            lng: longitude,
            accuracy,
          });
        },

        (err) => {
          setError(
            err.message
          );
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

  return {
    coordinates,
    loading,
    error,
  };
}