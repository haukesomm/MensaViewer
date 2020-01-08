import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mensaviewer/models/meal.dart';

/// Widget displaying a number of [Meal]s in a [ListView]
/// 
/// The individual lit items contain a main title with the description of the
/// respective dish displayed, the price and a so called 'diet-label' quickly
/// indicating whther a meal is vegan, vegetarian or non-vegetarian 
/// (animal-based).
class MealListWidget extends StatelessWidget {

  final List<Meal> _meals;

  /// Constructor
  MealListWidget(this._meals, {Key key})
    : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _meals.length,
      itemBuilder: (context, i) {
        return _buildMealListTile(context, i);
      },
    );
  }

  /// Returns the constructed list-tile as described in the class-level 
  /// documentation
  Widget _buildMealListTile(BuildContext context, int position) {
    var meal = _meals[position];
    return ListTile(
      title: Text(
        meal.dish
      ),
      trailing: Text(
        "${meal.price} €"
      ),
      subtitle: _buildDietLabelForMeal(context, meal  ),
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
    return Row(
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
    );
  }
}