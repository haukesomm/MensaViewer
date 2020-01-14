import 'package:flutter/material.dart';
import 'package:mensaviewer/ui/meal_list_page.dart';


void main() => runApp(MensaViewer());


class MensaViewer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mensa Viewer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MealListPage(),
    );
  }
}
