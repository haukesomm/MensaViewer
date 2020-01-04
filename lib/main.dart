import 'package:flutter/material.dart';


void main() => runApp(MensaViewer());


class MensaViewer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MensaViewerHome(),
    );
  }
}


class MensaViewerHome extends StatefulWidget {

  MensaViewerHome({Key key}) : super(key: key);

  @override
  _MensaViewerHomeState createState() => _MensaViewerHomeState();
}

class _MensaViewerHomeState extends State<MensaViewerHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mensa Viewer'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello World!',
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
