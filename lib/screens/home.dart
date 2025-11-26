import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../services/api_service.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final sorted = List<Category>.from(_filteredCategories)
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
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle, color: Colors.orange),
            tooltip: 'Random Recipe',
            onPressed: () async {
              final randomRecipe = await _apiService.fetchRandom();
              Navigator.pushNamed(context, '/details', arguments: randomRecipe.id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final category = sorted[index];
                return CategoryCard(category: category,);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadCategories() async {
    final categoryList = await _apiService.fetchCategories();
    setState(() {
      _categories = categoryList;
      _filteredCategories = categoryList;
      _isLoading = false;
    });

  }

  void _searchCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
