import 'gps_location.dart';
import 'user.dart';

abstract class Vehicle with GpsLocation {
  final String id;
  int bateriaPercentatge; // o a 100
  bool enUs = false;
  final double preuPerMinut;

  Vehicle({
    required this.id,
    required this.bateriaPercentatge,
    required this.preuPerMinut,
    required double latitud,
    required double longitud,
  }) {
    if (bateriaPercentatge < 0 || bateriaPercentatge > 100) {
      throw ArgumentError('La bateria ha d\'estar entre 0 i 100');
    }
    actualitzarUbicacio(latitud, longitud);
  }

  /// Switch Expression
  String estatBateria() => switch (bateriaPercentatge) {
    >= 80 => 'Alta',
    >= 20 => 'Mitjana',
    _ => 'Crítica (requereix càrrega)',
  };

  /// Mètode abstracte, cada subclasse calcula el cost amb una manera pròpia
  double calcularCostReserva(int minuts, {User? usuari});

  /// Format complet: utilitzat a la inicialització
  @override
  String toString() =>
      '\n$runtimeType: $id, \n'
      'bateria: $bateriaPercentatge% [${estatBateria()}], \n'
      'preu per minut: $preuPerMinut €,\n'
      'latitud: $latitud, \n'
      'longitud: $longitud, \n'
      'en ús: $enUs';

  //Format curt: utilitzat a cerca i filtres
  String resum() => '$id, bateria: $bateriaPercentatge% [${estatBateria()}]';
}
