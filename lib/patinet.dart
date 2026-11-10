import 'user.dart';
import 'vehicle.dart';

class Patinet extends Vehicle {
  final int velocitatMaxima; //km/h

  Patinet({
    required super.id,
    required super.bateriaPercentatge,
    required super.preuPerMinut,
    required super.latitud,
    required super.longitud,
    required this.velocitatMaxima,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    final cost = minuts * preuPerMinut;
    //10% de descompte per usuaris VIP
    if (usuari != null && usuari.esVIP) {
      return cost * 0.90;
    }
    return cost;
  }
}
