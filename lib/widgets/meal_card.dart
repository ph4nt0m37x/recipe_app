import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/details.dart';


class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {

    Color color = Colors.orangeAccent;
    Color text = Colors.white;

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(mealId: meal.id)));
        },
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            color: color,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(child: Image.network(meal.img, fit: BoxFit.cover))
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        meal.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: text,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // shows ... if text is too long
                      ),
                    ),
                  ),
                ],
              ),)
        )
    );
  }
}