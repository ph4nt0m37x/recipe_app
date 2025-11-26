import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal.dart';
import 'models/category.dart';
import 'screens/details.dart';
import 'screens/home.dart';
import 'screens/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe book!',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomeScreen(),
      initialRoute: "/",
      routes: {
        '/meals': (context) => MealsScreen(category: ModalRoute.of(context)!.settings.arguments as String),
        "/details": (context) => DetailsScreen(
          mealId: ModalRoute.of(context)!.settings.arguments as String)
      }
    );
  }
}
