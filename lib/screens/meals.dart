import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../services/api_service.dart';
class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MealsScreen> {
  late final List<Meal> _meals;
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    final sorted = List<Meal>.from(_filteredMeals)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(color: Colors.black87, height: 5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final meal = sorted[index];
                return MealCard(meal: meal,);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadMeals() async {
    final mealList = await _apiService.fetchMeals(widget.category);
    setState(() {
      _meals = mealList;
      _filteredMeals = mealList;
      _isLoading = false;
    });
  }

  Future<void> _searchMeals(String query) async {

    if (query.isEmpty) {
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final meals = await _apiService.searchMeals(query);

    setState(() {
      _isSearching = false;
      _filteredMeals = meals;
    });
  }
}
