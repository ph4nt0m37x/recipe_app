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
  late Details _details;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  void loadMeal() async {
    final data = await _apiService.fetchDetails(widget.mealId);
    setState(() {
      _details = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    Color color = Colors.white;

    return Scaffold(
      appBar: AppBar(title: Text("Recipe Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView (
          children: [
            Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Column(
            children: [
              Row(children: [Divider()]),

                  SizedBox(width: 8),
                  Text(
                    _details.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold, overflow: TextOverflow.visible, color: color
                    ), softWrap: true,
                  ),

              Divider(),
              Row(
                children: [
                  Expanded(child: Image.network(_details.img))
                ],
              ),
              Row(children: [Divider()]),
              Row(children: [
                SizedBox(width: 8),
                Text("Ingredients for this recipe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),),
                ]),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(child:
                  Text(_details.ingredients, style: TextStyle(fontSize: 18, color: color)),
                  )
                ],
              ),
              Row(children: [
                SizedBox(width: 8),
                Text("How to prepare it", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),),]),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(child:
                  Text(_details.instructions, style: TextStyle(fontSize: 18, color: color)),
                  )
                ],
              ),
              Row(children: [Divider()]),


              _details.link.isNotEmpty ? Row(

                  children: [
                    SizedBox(width: 8),
                    Expanded(child:
                    Text("Source: " + _details.link, style: TextStyle(
                        fontSize: 18, color: color)),
                    )
                  ],
                ) : SizedBox.shrink(),
            ],
          ),
        )
      ),
    ]
      ));


  }

}