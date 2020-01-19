import 'package:flutter/material.dart';

import 'package:mensaviewer/data/mensa_repository.dart';
import 'package:mensaviewer/data/ondevice_mensa_repository.dart';
import 'package:mensaviewer/models/mensa.dart';
import 'package:mensaviewer/ui/error_screen_widget.dart';
import 'package:mensaviewer/ui/loading_screen_widget.dart';
import 'package:mensaviewer/ui/mensa_list_widget.dart';


// Status codes used to indicate whether the MensaSelectorFragment is currently
// getting a list of available Mensas, has successfully retrieved a list of
// available Mensas or ran into error while doing so.
// Based on the status code defined in it's State it will then display the
// appropriate UI.

const int _statusLoadingMensas = 0;

const int _statusMensasLoaded = 1;

const int _statusErrorLoadingMensas = 2;


/// Bottom navigation sheet displaying a number of [Mensa]s that can be selected
/// by the user in order to quickly navigate between their respective UIs.
class MensaSelectorWidget extends StatefulWidget {

  final MensaRepository _repo;

  final Function(Mensa) _onMensaSelected;

  /// Constructor
  MensaSelectorWidget({Key key, Function(Mensa) onMensaSelected}) 
    : _repo = OnDeviceMensaRepository(),
      _onMensaSelected = onMensaSelected,
      super(key: key);


  @override
  State<StatefulWidget> createState() => _MensaSelectorWidgetState();
}

/// State class displaying different widgets based on which status code is set.
/// 
/// Upon creation of the widget a list of [Mensa]s is asynchronously requested
/// from a [MensaRepository]. Until no result was received, a loading animation
/// is shown to the user.
/// Once a successful result was recived the widget automatically switches to 
/// the actual list of [Mensa]s available.
/// In case of an error a error-message will be shown to the user instead.
class _MensaSelectorWidgetState extends State<MensaSelectorWidget> {

  int _mode = _statusLoadingMensas;

  List<Mensa> _mensas = [];

  @override
  void initState() {
    super.initState();

    widget._repo.getAllMensas()
      .then(
        (mensas) {
          setState(() {
            _mensas = mensas;
            _mode = _statusMensasLoaded;
          });
        }
      )
      .catchError(
        (e) {
          setState(() {
            _mode = _statusErrorLoadingMensas;
          });
        }
      );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_mode) {
      case _statusLoadingMensas:
        body = LoadingScreenWidget('Loading Mensas');
        break;

      case _statusMensasLoaded:
        body = MensaListWidget(
          _mensas,
          onMensaSelected: widget._onMensaSelected,
        );
        break;

      case _statusErrorLoadingMensas:
        body = ErrorScreenWidget('There was an error loading the Mensas.');
        break;
    }

    return Container(
      child: body,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
    );
  }
}