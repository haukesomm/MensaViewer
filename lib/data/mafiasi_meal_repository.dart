import 'dart:convert';

import 'package:http/http.dart';

import 'package:mensaviewer/data/meal_repository.dart';
import 'package:mensaviewer/models/meal.dart';

/// [MealRepository] retrieving [Meal]s from the Mafiasi.de-API
class MafiasiMealRepository implements MealRepository {

  static const String _apiUrlBase = "https://mensa.mafiasi.de/api";
  static const String _apiEndpointCanteens = "$_apiUrlBase/canteens";

  /// Retrieves a [List] of [Meal]s served in the given [mensa] on the given
  /// [day] from the Mafiasi-API.
  /// 
  /// The day parameter can either be 'today' or 'tomorrow'.
  Future<List<Meal>> _getMealsForDay(int mensaId, String day) async {
    final List<Meal> meals = [];

    final String url = "$_apiEndpointCanteens/$mensaId/$day";
    final Response response = await get(url);
    
    final jsonMeals = jsonDecode(response.body);
    assert (jsonMeals is List);

    for (final jsonMeal in jsonMeals) {
      assert (jsonMeal is Map);
      meals.add(Meal.fromJson(jsonMeal));
    }

    return meals;
  }

  @override
  Future<List<Meal>> getMealsForCurrentDay(int mensaId) async => 
    await _getMealsForDay(mensaId, 'today');

  @override
  Future<List<Meal>> getMealsForNextDay(int mensaId) async => 
    await _getMealsForDay(mensaId, 'tomorrow');
}