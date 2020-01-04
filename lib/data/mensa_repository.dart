import 'package:mensaviewer/models/mensa.dart';

/// An interface for repositories storing [Mensa] objects
abstract class MensaRepository {

  /// Returns a list of all [Mensa]s in the repository
  Future<List<Mensa>> getAllMensas();
}