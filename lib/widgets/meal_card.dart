import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/details.dart';
import '../helper/favorites_helper.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  _MealCardState createState() => _MealCardState();

}
class _MealCardState extends State<MealCard> {

  @override
  Widget build(BuildContext context) {

    Color color = Colors.orangeAccent;
    Color text = Colors.white;

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(mealId: widget.meal.id)));
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

                  Stack(
                    children: [
                      Image.network(
                        widget.meal.img,
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            widget.meal.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              toggleFavorite(widget.meal);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.meal.name,
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