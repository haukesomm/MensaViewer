import 'package:mensaviewer/models/mensa.dart';

/// An interface for repositories storing [Mensa] objects
/// 
/// In this project a list of all [Mensa]s can be retrieved from multiple
/// sources like the Mafiasi-API or an offline database which is why this extra
/// layer of abstraction exists.
abstract class MensaRepository {

  /// Returns a list of all [Mensa]s in the repository
  Future<List<Mensa>> getAllMensas();
}