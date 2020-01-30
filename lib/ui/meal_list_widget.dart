import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mensaviewer/models/meal.dart';

/// Widget displaying a number of [Meal]s in a [ListView]
/// 
/// The individual lit items contain a main title with the description of the
/// respective dish displayed, the price and a so called 'diet-label' quickly
/// indicating whther a meal is vegan, vegetarian or non-vegetarian 
/// (animal-based).
/// 
/// The widget is also capable of displaying [Meal]s from multiple days and 
/// separates those automatically by placing subheaders in between of them.
/// Therefor the list of items passed in the construcotr will be automatically
/// sorted.
class MealListWidget extends StatelessWidget {

  final List<Meal> _meals;

  /// Constructor
  MealListWidget(this._meals, {Key key})
    : super(key: key) {
    _sortMealsByDate(_meals);
  }


  /// Takes an arbitrary list of [Meal]s and groups/sorts the items by date.
  /// 
  /// This is useful when the list should contain meals from multiple days and
  /// an unordered list of items is passed into the widget constructor.
  void _sortMealsByDate(List<Meal> meals) {
    meals.sort((m1, m2) {
        return m1.date.compareTo(m2.date);
      });
  }


  /// Returns true if a subheader should be included between the last list item
  /// and the item at the given position.
  bool _shouldIncludeSubheader(int position) => 
    position == 0 || _meals[position].date != _meals[position - 1].date;


  /// Takes a date-formatted String and formats it so it can be displayed to the
  /// user.
  /// 
  /// Ouput-format: EEEE, dd.MM.yyyy (<WEEKDAY>, <DAY>.<MONTH>.<YEAR>)
  String _formatDate(String date) {
    final datetime = DateTime.parse(date);
    final formatter = DateFormat("EEEE, dd.MM.yyyy");
    return formatter.format(datetime);
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _meals.length,
      itemBuilder: (context, i) {
        return _buildMealListTile(context, i);
      },
      separatorBuilder: (context, i) {
        return Divider();
      },
    );
  }

  /// Returns the constructed list-tile as described in the class-level 
  /// documentation
  Widget _buildMealListTile(BuildContext context, int position) {
    final meal = _meals[position];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (_shouldIncludeSubheader(position)) Container(
          margin: EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 16,
          ),
          child: Text(
            _formatDate(meal.date),
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        ListTile(
          title: Text(
            meal.dish
          ),
          trailing: Text(
            "${meal.price} €"
          ),
          subtitle: _buildDietLabelForMeal(context, meal),
        ),
      ],
    );
  }

  /// Returns a diet-label based on the properties of the given [meal].
  /// 
  /// A differently looking label will be returned based on whether the meal
  /// is vegan, vegetarian or non-vegetarian. 
  Widget _buildDietLabelForMeal(BuildContext context, Meal meal) {
    if (meal.isVegan) {
      return _buildDietLabel(context, MdiIcons.leaf, Colors.green[500], 'Vegan');
    } else if (meal.isVegetarian) {
      return _buildDietLabel(context, MdiIcons.leaf, Colors.green[800], 'Vegetarian');
    } else {
      return _buildDietLabel(context, MdiIcons.pig, Colors.pink[300], 'Non-Vegetarian');
    }
  }

  /// Returns a diet-label based on the given [iconData], [color] and [caption].
  Widget _buildDietLabel(BuildContext context, IconData iconData, Color color, String caption) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: 18,
            color: color,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 8,
            ),
            child: Text(
              caption
            ),
          )//
        ],
      ),
    );
  }
}