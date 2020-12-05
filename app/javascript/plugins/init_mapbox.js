import mapboxgl from 'mapbox-gl';
const mapElement = document.getElementById('map');

const buildMap = (mapElement) => {
  if (mapElement){
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  }
};

const addMarkersToMap = (map, markers) => {
    if (mapElement) {
    // [ ... ]
    const marker = JSON.parse(mapElement.dataset.markers);
      new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
    }
  if (mapElement){
    fitMapToMarkers(map, markers);
  }
};


const fitMapToMarkers = (map, marker) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ marker.lng, marker.lat ]);
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {

  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };