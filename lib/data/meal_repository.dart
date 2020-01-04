import 'package:mensaviewer/models/meal.dart';


/// An interface for repositories storing [Meal] objects
abstract class MealRepository {

  /// Returns a List of [Meal]s served in the Mensa with the given [mensaId] at
  /// the current day.
  Future<List<Meal>> getMealsForCurrentDay(int mensaId);

  /// Returns a List of [Meal]s served in the Mensa with the given [mensaId] at
  /// the following day.
  Future<List<Meal>> getMealsForNextDay(int mensaId);
}