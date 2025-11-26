import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/details.dart';

class DetailsScreen extends StatefulWidget {
  final String mealId;

  const DetailsScreen({super.key, required this.mealId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>{
  late Details details;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  void loadMeal() async {
    final data = await _apiService.fetchDetails(widget.mealId);
    setState(() => details = data);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(details.name)),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(children: [Divider()]),

            Row(
              children: [
                SizedBox(width: 8),
                Text(
                  details.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: Image.network(details.img))
              ],
            ),
            Row(children: [Divider()]),
            Row(
              children: [
                SizedBox(width: 8),
                Expanded(child:
                Text(details.ingredients, style: TextStyle(fontSize: 20)),
                )
              ],
            ),
            Row(children: [Divider()]),
            Row(
              children: [
                SizedBox(width: 8),
                Expanded(child:
                Text(details.instructions, style: TextStyle(fontSize: 20)),
                )
              ],
            ),
            Row(children: [Divider()]),
            Row(
              children: [
                SizedBox(width: 8),
                Text(details.link, style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );


  }



}