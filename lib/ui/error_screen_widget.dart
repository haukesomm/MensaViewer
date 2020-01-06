import 'package:flutter/material.dart';

/// Widget displaying a given error-message to the user
class ErrorScreenWidget extends StatelessWidget {

  final String _message;

  ErrorScreenWidget(this._message, {Key key})
    : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_message),
        ],
      ),
    );
  }
}