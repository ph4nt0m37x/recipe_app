import 'package:flutter/material.dart';
import '../models/category.dart';


class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});


  @override
  Widget build(BuildContext context) {

    Color color = Colors.orangeAccent;
    Color text = Colors.white;

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/meals", arguments: category.name);
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
                      Expanded(child: Image.network(category.img))
                    ],
                  ),

                  Row (
                    children: [

                      SizedBox(width: 8),
                      Text(category.name, style: TextStyle(fontSize: 22, color: text, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Expanded(child:
                      Text(category.desc, style: TextStyle(fontSize: 12, color: text)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Divider()
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