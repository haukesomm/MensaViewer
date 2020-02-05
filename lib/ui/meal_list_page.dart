import 'package:flutter/material.dart';

import 'package:mensaviewer/data/mafiasi_meal_repository.dart';
import 'package:mensaviewer/data/meal_repository.dart';
import 'package:mensaviewer/models/meal.dart';
import 'package:mensaviewer/models/mensa.dart';
import 'package:mensaviewer/ui/error_screen_widget.dart';
import 'package:mensaviewer/ui/loading_screen_widget.dart';
import 'package:mensaviewer/ui/meal_list_widget.dart';
import 'package:mensaviewer/ui/mensa_not_selected_widget.dart';
import 'package:mensaviewer/ui/mensa_selector_widget.dart';
import 'package:mensaviewer/ui/settings_page.dart';


// TODO: Use FutureBuilder class instead of hard-coded state-flags

const int _statusNoMensaSelected = 0;

const int _statusMealsLoading = 1;

const int _statusMealsLoaded = 2;

const int _statusErrorLoadingMeals = 3;


/// A widget/page that hosts widgets to select a [Mensa] and display the
/// respective [Meals].
///
/// It also displays loading- and error-screens depending on whether the meals
/// served in a canteen could be successfully retrieved.
class MealListPage extends StatefulWidget {

  final MealRepository _repo = MafiasiMealRepository();

  
  @override
  State<StatefulWidget> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {

  String _title = 'Mensa Viewer';
  
  int _status = _statusNoMensaSelected;

  Mensa _mensa;

  List<Meal> _meals = [];


  @override
  void initState() {
    super.initState();
    
    _startLoadingMeals();
  }


  /// Starts getting the list of [Meal]s served in the currently set [_mensa].
  /// 
  /// Depending on whether the meals could successfully be retrieved the state
  /// of the widget will either be set to display the meals or an eeror screen
  /// instead.
  /// 
  /// See: [_onMensaSelected(mensa)]
  void _startLoadingMeals() {
    if (_mensa != null) {
      widget._repo.getAllAvailableMeals(_mensa.id)
        .then(
          (meals) {
            _onMealsLoaded(meals);
          }
        ).catchError(
          (e) {
            print("An error occurred loading the meals: $e");
            _status = _statusErrorLoadingMeals;
          }
        );
    } else {
      // log warning
    }
  }


  /// Updates the widget's state to use the specified [mensa] and load the
  /// associated meals.
  void _onMensaSelected(Mensa mensa) {
    Navigator.pop(context);
    setState(() {
      _mensa = mensa;
      _title = mensa.name;
      _status = _statusMealsLoading;
    });
  }

  /// Updates the widget's state to display the given [meals].
  void _onMealsLoaded(List<Meal> meals) {
    setState(() {
      _meals = meals;
      _status = _statusMealsLoaded;  
    });
  }

  
  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_status) {
      case _statusNoMensaSelected:
        body = MensaNotSelectedWidget();
        break;

      case _statusMealsLoading:
        body = LoadingScreenWidget('Loading Meals');
        _startLoadingMeals();
        break;

      case _statusMealsLoaded:
        body = MealListWidget(_meals);
        break;

      case _statusErrorLoadingMeals:
        body = ErrorScreenWidget('Sorry, there was an error loading the Meals.');
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title
        ),
      ),

      body: body,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) {
          return _buildFloatingActionButton(context);
        },
      ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.arrow_drop_up),
      label: Text('Mensa'),
      onPressed: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            child: MensaSelectorWidget(
              onMensaSelected: _onMensaSelected,
            ),
          );
        });
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildAppBarButton(
              context: context, 
              iconData: Icons.insert_chart, 
              title: 'Stats',
              onPressed: () {},
            ),

            _buildAppBarButton(context: context, 
              iconData: Icons.settings, 
              title: 'Settings',
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => SettingsPage()
                  )
                );
              }
            ),
          ],
        ),
      ),
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        StadiumBorder(side: BorderSide())
      ),
    );
  }

  /// Builds an Appbar-Button consisting of an Icon (passed in via [iconData])
  /// and a [title] below it.
  /// 
  /// An onPressed-Function needs to be specified via the [onPressed] parameter.
  Widget _buildAppBarButton({
    @required context, 
    @required IconData iconData, 
    @required String title,
    @required Function(void) onPressed(),
  }) {
    return FlatButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: Theme.of(context).accentColor,
          ),
          Text(
            title
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}