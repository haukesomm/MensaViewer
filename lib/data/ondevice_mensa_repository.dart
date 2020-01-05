import 'package:mensaviewer/data/mensa_repository.dart';
import 'package:mensaviewer/models/mensa.dart';

/// [MensaRepository] containing a hard-coded list of [Mensa]s.
/// 
/// Note: Since the list of [Mensa]s is hard-coded (for development and fallback
/// purposes) the data may not be up-to-date!
class OnDeviceMensaRepository implements MensaRepository {
  
  @override
  Future<List<Mensa>> getAllMensas() async {
    return <Mensa>[
      Mensa(1, 'Bergedorf'),
      Mensa(2, 'Bucerius Law School'),
      Mensa(3, 'Café Berliner Tor'),
      Mensa(4, 'Café CFEL'),
      Mensa(5, 'Café Jungiusstraße'),
      Mensa(6, 'Campus'),
      Mensa(7, 'Geomatikum'),
      Mensa(8, 'Harburg'),
      Mensa(10, 'Stellingen'),
      Mensa(11, 'Studierendenhaus'),
      Mensa(12, 'Berliner Tor (HAW)'),
      Mensa(13, 'Überseering'),
      Mensa(14, 'DESY'),
      Mensa(15, 'Armgartstraße'),
      Mensa(16, 'Botanischer Garten'),
      Mensa(17, 'Café Alexanderstraße'),
      Mensa(18, 'Café Finkenau'),
      Mensa(19, 'Café Mittelweg'),
      Mensa(20, 'Hafen-City Universität'),
    ];
  }
}
