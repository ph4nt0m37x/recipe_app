import 'package:flutter/material.dart';
import 'meal_card.dart';

import '../models/meal.dart';

class MealGrid extends StatefulWidget {
  final List<Meal> meals;

  const MealGrid({super.key, required this.meals});

  @override
  State<StatefulWidget> createState() => _MealGridState();
}

class _MealGridState extends State<MealGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 200/244
      ),
      itemCount: widget.meals.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: widget.meals[index]);
      },
    );
  }
}
