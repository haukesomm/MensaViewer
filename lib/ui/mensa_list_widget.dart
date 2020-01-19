import 'package:flutter/material.dart';

import 'package:mensaviewer/models/mensa.dart';

/// Widget displaying a number of [Mensa]s in a [ListView]
class MensaListWidget extends StatelessWidget {

  final List<Mensa> _mensas;

  final Function(Mensa) _onMensaSelected;

  /// Creates a new instance displaying a number of given [_mensas]
  MensaListWidget(this._mensas, {Key key, Function(Mensa) onMensaSelected}) 
    : this._onMensaSelected = onMensaSelected,
      super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _mensas.length,
      itemBuilder: (context, i) {
        return _buildListItem(context, i);
      },
    );
  }

  Widget _buildListItem(BuildContext context, int position) {
    final Mensa currentMensa = _mensas[position];

    return ListTile(
      title: Text(
        currentMensa.name
      ),
      onTap: () {
        if (_onMensaSelected != null) {
          _onMensaSelected(currentMensa);
        }
      },
    );
  }
}