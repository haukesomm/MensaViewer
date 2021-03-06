import 'package:flutter/material.dart';

import 'package:mensaviewer/data/mafiasi_meal_repository.dart';
import 'package:mensaviewer/data/meal_repository.dart';
import 'package:mensaviewer/data/shared_preferences_helper.dart' as prefs;
import 'package:mensaviewer/models/meal.dart';
import 'package:mensaviewer/models/mensa.dart';
import 'package:mensaviewer/ui/error_screen_widget.dart';
import 'package:mensaviewer/ui/loading_screen_widget.dart';
import 'package:mensaviewer/ui/meal_list_widget.dart';
import 'package:mensaviewer/ui/mensa_not_selected_widget.dart';
import 'package:mensaviewer/ui/mensa_selector_widget.dart';
import 'package:mensaviewer/ui/settings_page.dart';


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

  bool _noMensaSelected = true;

  Mensa _mensa;

  bool _userIsStaff = false;


  @override
  void initState() {
    super.initState();
    _initSharedPreferenceValues();
  }


  Future<bool> _getUserIsStaff() async {
    return await prefs.getPreferenceValue(prefs.userIsStaff);
  }

  Future<List<Meal>> _loadMeals() async {
    return await widget._repo.getAllAvailableMeals(_mensa.id);
  }


  /// Reads from the app's shared preferences and initializes the respective
  /// fields accordingly.
  void _initSharedPreferenceValues() {
    _getUserIsStaff()
      .then((onValue) {
        setState(() {
          _userIsStaff = onValue;
        });
      });
  }


  /// Updates the widget's state to use the specified [mensa] and load the
  /// associated meals.
  void _onMensaSelected(Mensa mensa) {
    Navigator.pop(context);
    setState(() {
      _noMensaSelected = false;
      _title = mensa.name;
      _mensa = mensa;
    });
  }


  /// Shows the app's settings page and re-initializes the shared preference
  /// fields.
  /// 
  /// A full re-build is triggered via the 'setState()' method for the UI to
  /// refelct the settings.
  void _showSettingsPage() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SettingsPage()
      )
    )
    .then((result) { _initSharedPreferenceValues(); });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Display a chip indicating whether the current user is a student or staff
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _title
            ),
            _buildStaffIndicator(context),
          ],
        )
      ),

      body: _buildBody(context),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) {
          return _buildFloatingActionButton(context);
        },
      ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStaffIndicator(BuildContext context) {
    return Chip(
      label: Text(
        _userIsStaff ? 'Staff' : 'Student'
      ),
      avatar: Container(
        margin: EdgeInsets.only(
          left: 4,
          right: 4,
        ),
        child: Icon(
          _userIsStaff ? Icons.computer : Icons.school,
          color: Theme.of(context).accentColor,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  // TODO: Display empty message if the future completed successfully but did
  // not return any meals.
  Widget _buildBody(BuildContext context) {
    if (_noMensaSelected) {
      return MensaNotSelectedWidget();
    }

    return FutureBuilder(
      future: _loadMeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MealListWidget(snapshot.data, _userIsStaff);

        } else if (snapshot.hasError) {
          return ErrorScreenWidget('There was an error loading the Meals.');

        } else {
          return LoadingScreenWidget('Loading Meals');
        }
      }
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

            // Just here to add some extra space
            Container(),

            _buildAppBarButton(
              context: context, 
              iconData: Icons.settings, 
              title: 'Settings',
              onPressed: _showSettingsPage,
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
    @required void Function() onPressed,
  }) {
    return FlatButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: Theme.of(context).primaryColor,
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