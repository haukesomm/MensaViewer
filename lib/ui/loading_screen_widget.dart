import 'package:flutter/material.dart';

/// Widget displaying a circular loading animation together with a given message
class LoadingScreenWidget extends StatelessWidget {

  final String _message;

  LoadingScreenWidget(this._message, {Key key})
    : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
          Text(_message),
        ],
      ),
    );
  }
}