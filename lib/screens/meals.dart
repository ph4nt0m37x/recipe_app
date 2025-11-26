import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../services/api_service.dart';
import '../widgets/meal_grid.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> _meals = [];
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
        title: const Text(
            'Recipe Book', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(color: Colors.black87, height: 5),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
          children: [
      Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search meals by name...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
          _searchMeals(value);
        },
      ),
    ),
            Expanded(
              child: _filteredMeals.isEmpty && _searchQuery.isNotEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No meals found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _isSearching
                          ? null
                          : () async {
                        await _searchMeals(_searchQuery);
                      },
                      child: _isSearching
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Search in API'),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MealGrid(meals: _filteredMeals),
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
    // setState(() {
    //   _isSearching = true;
    // });

    final meals = await _apiService.searchMeals(query);

    setState(() {
      _isSearching = false;
      _filteredMeals = meals;
    });
  }
}
