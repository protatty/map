<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Live GPS Overlay</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link
    rel="stylesheet"
    href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"
  />
  <style>
    html, body, #map {
      margin: 0; padding: 0;
      width: 100vw; height: 100vh;
      background: transparent;
    }
  </style>
</head>
<body>
  <div id="map"></div>
  <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
  <script>
    // Создаём карту
    const map = L.map('map', { zoomControl: false, attributionControl: false });
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
    const marker = L.marker([0, 0]).addTo(map);

    // Проверяем поддержку и запускаем отслеживание
    if ('geolocation' in navigator) {
      navigator.geolocation.watchPosition(
        pos => {
          const lat = pos.coords.latitude;
          const lon = pos.coords.longitude;
          marker.setLatLng([lat, lon]);
          map.setView([lat, lon], 16);
        },
        err => console.warn('GPS error:', err),
        { enableHighAccuracy: true, maximumAge: 1000, timeout: 5000 }
      );
    } else {
      alert('Geolocation API не поддерживается');
    }
  </script>
</body>
</html>
