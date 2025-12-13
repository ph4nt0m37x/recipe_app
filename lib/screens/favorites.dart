import 'package:flutter/material.dart';
import '../widgets/meal_grid.dart';
import '../helper/favorites_helper.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: favoriteMeals.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : MealGrid(meals: favoriteMeals),
    );
  }
}
