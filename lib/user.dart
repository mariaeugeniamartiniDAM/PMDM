/// Excepció personalitzada per a quantitats de saldo no vàlides.
class SaldoInvalidException implements Exception {
  final String missatge;
  SaldoInvalidException(this.missatge);

  @override
  String toString() => 'SaldoInvalidException: $missatge';
}

class User {
  // Atributs privats.
  final String _id;
  String _nomComplet;
  double _saldo;

  //Atributs públics.
  String correu;
  bool esVIP;

  /// Constructor nombrat: usuari nou amb saldo inicial 0.0
  User.nou({required String id, required String nom, required this.correu})
    : _id = id,
      _nomComplet = nom,
      _saldo = 0.0,
      esVIP = false;

  /// Construct complet amb tots els paràmetres
  User(
    this._id,
    this._nomComplet,
    this._saldo,
    this.correu, {
    this.esVIP = false,
  });

  // Getters
  String get id => _id;
  double get saldo => _saldo;
  String get nomComplet => _nomComplet;

  /// Recarrega saldo. No permet quantitats negatives o zero.
  void recarregarSaldo(double quantitat) {
    if (quantitat <= 0) {
      throw SaldoInvalidException(
        'La quantitat a recarregar ha de ser positiva (rebut: $quantitat)',
      );
    }
    _saldo += quantitat;
  }

  @override
  String toString() =>
      'User($_id, $_nomComplet, $correu, saldo: ${_saldo.toStringAsFixed(2)}€, VIP: $esVIP)';
}
