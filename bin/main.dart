import 'package:ecoride/cotxe.dart';
import 'package:ecoride/patinet.dart';
import 'package:ecoride/user.dart';
import 'package:ecoride/vehicle.dart';

void main() {
  // 1. Inicialització
  print('--- 1. INICIALITZACIÓ DE LA FLOTA ---');
  final List<Vehicle> flota = [
    Patinet(
      id: 'PAT-01',
      bateriaPercentatge: 95,
      preuPerMinut: 0.25,
      latitud: 39.5768,
      longitud: 2.6561,
      velocitatMaxima: 15,
    ),
    Patinet(
      id: 'PAT-02',
      bateriaPercentatge: 65,
      preuPerMinut: 0.30,
      latitud: 39.5731,
      longitud: 2.6607,
      velocitatMaxima: 25,
    ),
    Patinet(
      id: 'PAT-03',
      bateriaPercentatge: 15,
      preuPerMinut: 0.40,
      latitud: 39.5757,
      longitud: 2.6493,
      velocitatMaxima: 35,
    ),
    Cotxe(
      id: 'COT-01',
      bateriaPercentatge: 80,
      preuPerMinut: 0.45,
      latitud: 39.5752,
      longitud: 2.6548,
      places: 4,
      requereixLlicencia: true,
    ),
    Cotxe(
      id: 'COT-02',
      bateriaPercentatge: 20,
      preuPerMinut: 0.60,
      latitud: 39.5446,
      longitud: 2.3882,
      places: 2,
      requereixLlicencia: false,
    ),
    Cotxe(
      id: 'COT-03',
      bateriaPercentatge: 32,
      preuPerMinut: 0.65,
      latitud: 39.5469,
      longitud: 2.7291,
      places: 7,
      requereixLlicencia: true,
    ),
  ];

  // Un cotxe en ús, per provar el filtre
  flota[4].enUs = true;

  for (final v in flota) {
    print(v);
  }

  // 2. Cerca i filtres
  print('\n--- 2. CERCA I FILTRES ---');
  final millorBateria = flota.reduce(
    (a, b) => a.bateriaPercentatge >= b.bateriaPercentatge ? a : b);
  print('Vehicle amb la bateria més alta: $millorBateria');

  final disponibles =
    flota.where((v) => v.bateriaPercentatge > 20 && !v.enUs.toList();
    print('Vehicles amb bateria major al 20% i lliures (${disponibles.length}):');
    for (final v in disponibles) {
      print(' - $v');
    }
}
