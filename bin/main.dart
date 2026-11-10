import 'package:ecoride/cotxe.dart';
import 'package:ecoride/patinet.dart';
import 'package:ecoride/user.dart';
import 'package:ecoride/vehicle.dart';

void main() {
  // 1. Inicialització
  print('\n--- 1. INICIALITZACIÓ DE LA FLOTA ---');
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
    (a, b) => a.bateriaPercentatge >= b.bateriaPercentatge ? a : b,
  );
  print('\nVehicle amb la bateria més alta: ${millorBateria.resum()}');

  final disponibles = flota
      .where((v) => v.bateriaPercentatge > 20 && !v.enUs)
      .toList();
  print(
    '\nVehicles amb bateria major al 20% i lliures (${disponibles.length}):',
  );
  for (final v in disponibles) {
    print(' - ${v.resum()}');
  }

  // 3. Simulació d'ús i Records
  print('\n--- 3. SIMULACIÓ DE RESERVA ---');
  final usuari1 = User.nou(
    id: 'U-001',
    nom: 'Ana Garcia Torres',
    correu: 'anagt@ecoride.cat',
  );
  usuari1.esVIP = true;
  usuari1.recarregarSaldo(30.0);

  final patinet = flota.whereType<Patinet>().first;
  const minuts = 15;
  final cost = patinet.calcularCostReserva(minuts, usuari: usuari1);
  patinet.enUs = true;
  print(
    '\n${usuari1.nomComplet} (VIP) ha reservat ${patinet.id} durant $minuts min.',
  );
  print('Cost calculat: ${cost.toStringAsFixed(2)} €.');

  patinet.actualitzarUbicacio(39.5582, 2.6758);
  var (lat, lng) = patinet.obtenirCoordenades(); //destructuracìó
  print('Nova posició de GPS de ${patinet.id}: latitud= $lat, longitud= $lng');

  //4. Maneig d'errors
  print('\n--- 4. MANEIG D\'ERRORS ---');

  // Prova 1: recàrrega NEGATIVA (ha de fallar)
  print('\nProva nº1');
  try {
    print('Saldo anterior: ${usuari1.saldo} €');
    usuari1.recarregarSaldo(-10.0);
    print('Recàrrega feta.'); // no ha d'imprimir això
  } on SaldoInvalidException catch (e) {
    print('Error capturat: ${e.missatge}');
  } finally {
    print('Saldo actual: ${usuari1.saldo} €');
  }

  // Prova 2: recàrrega POSITIVA (ha de funcionar)
  print('\nProva nº2');
  try {
    print('Saldo anterior: ${usuari1.saldo} €');
    usuari1.recarregarSaldo(8.0);
    print('Recàrrega feta.');
  } on SaldoInvalidException catch (e) {
    print('Error capturat: ${e.missatge}');
  } finally {
    print('Saldo actual: ${usuari1.saldo} €');
  }

  print('\nEl programa ha acabat correctament.');
}
