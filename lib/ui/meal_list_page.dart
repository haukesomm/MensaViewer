import 'package:flutter/material.dart';

import 'package:mensaviewer/data/mafiasi_meal_repository.dart';
import 'package:mensaviewer/data/meal_repository.dart';
import 'package:mensaviewer/models/meal.dart';
import 'package:mensaviewer/ui/error_screen_widget.dart';
import 'package:mensaviewer/ui/loading_screen_widget.dart';
import 'package:mensaviewer/ui/meal_list_widget.dart';


const int _statusMealListLoading = 0;

const int _statusMealListDisplaying = 1;

const int _statusMealListLoadingError = 2;


class MealListPage extends StatefulWidget {

  final MealRepository _repo = MafiasiMealRepository();

  
  @override
  State<StatefulWidget> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {

  int _status = _statusMealListLoading;

  List<Meal> _meals = [];


  @override
  void initState() {
    super.initState();
    
    // TODO: Retrieve mensa from bottom sheet
    // TODO: Implement error handling
    widget._repo.getAllAvailableMeals(10)
      .then(
        (meals) {
          setState(() {
            _meals = meals;
            _status = _statusMealListDisplaying;  
          });
        }
      ).catchError(
        (e) {
          print("An error occurred loading the meals: $e");
          _status = _statusMealListLoadingError;
        }
      );
  }
  
  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_status) {
      case _statusMealListLoading:
        body = LoadingScreenWidget('Loading Meals');
        break;

      case _statusMealListDisplaying:
        body = MealListWidget(_meals);
        break;

      case _statusMealListLoadingError:
        body = ErrorScreenWidget('There was an error loading the Meals for this day.');
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mensa Viewer"
        ),
      ),
      body: body,
    );
  }
}