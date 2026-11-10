import 'user.dart';
import 'vehicle.dart';

class Cotxe extends Vehicle {
  static const double suplementFiltreEcologic = 2.0;

  final int places;
  final bool requereixLlicencia;

  Cotxe({
    required super.id,
    required super.bateriaPercentatge,
    required super.preuPerMinut,
    required super.latitud,
    required super.longitud,
    required this.places,
    required this.requereixLlicencia,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    return (minuts * preuPerMinut) + suplementFiltreEcologic;
  }
}
