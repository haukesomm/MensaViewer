import 'package:flutter/material.dart';

import 'package:mensaviewer/models/mensa.dart';

/// Widget displaying a number of [Mensa]s in a [ListView]
class MensaListWidget extends StatelessWidget {

  final List<Mensa> _mensas;

  /// Creates a new instance displaying a number of given [_mensas]
  MensaListWidget(this._mensas, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _mensas.length,
      itemBuilder: (context, i) {
        return _MensaListItem(_mensas[i]);
      },
    );
  }
}

class _MensaListItem extends StatelessWidget {

  final Mensa _mensa;

  _MensaListItem(this._mensa, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _mensa.name
      ),
    );
  }
}