import '../models/meal.dart';

List<Meal> favoriteMeals = [];


void toggleFavorite(Meal meal)
{
  meal.isFavorite = !meal.isFavorite;
  if (meal.isFavorite) {
    if (!favoriteMeals.contains(meal)) {
      favoriteMeals.add(meal);
    }
  } else {
    favoriteMeals.removeWhere((m) => m.id == meal.id);
  }
}