/// Mixin que afegeix capacitat de geolocalització.
mixin GpsLocation {
  double latitud = 0.0;
  double longitud = 0.0;

  void actualitzarUbicacio(double lat, double lng) {
    latitud = lat;
    longitud = lng;
  }

  // Record de Dart
  (double lat, double lng) obtenirCoordenades() => (latitud, longitud);
}
