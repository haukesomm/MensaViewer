import 'package:flutter/material.dart';

/// A widget displaying a message that the user needs to choose a canteen.
class MensaNotSelectedWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: Icon(
              Icons.info
            ),
          ),
          Text(
            'Please choose a Mensa below.'
          )
        ],
      ),
    );
  }
}