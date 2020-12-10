import mapboxgl from 'mapbox-gl';

const buildMap = () => {
  const mapElement = document.getElementById('map');
  if (mapElement){
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/jpavailable/ckiinobkh0am019oxzjixjudr'
    });
  }
};

 const addMarkersToMap = (map, markers) => {
  const mapElement = document.getElementById('map');
    if (mapElement) {
      const customMarker = document.createElement('div');
      customMarker.className ='marker'

      const marker = JSON.parse(mapElement.dataset.markers);
        new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
      }
  if (mapElement){
     fitMapToMarkers(map, markers);
   }
 };


 const fitMapToMarkers = (map, marker) => {
  const mapElement = document.getElementById('map');
  if (mapElement){
     const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([ marker.lng, marker.lat ]);
     map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 0 });
  }
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
     addMarkersToMap(map, markers);
     fitMapToMarkers(map, markers);
  }
};

export { initMapbox };