import 'package:flutter/material.dart';
import '../models/meal.dart';


class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {

    Color color = Colors.orangeAccent;
    Color text = Colors.white;

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/details", arguments: meal.id);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            color: color,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(child: Image.network(meal.img))
                    ],
                  ),

                  Row (
                    children: [

                      SizedBox(width: 8),
                      Text(meal.name, style: TextStyle(fontSize: 22, color: text, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Divider()
                    ],
                  ),
                ],
              ),)
        )
    );
  }
}