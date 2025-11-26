import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/details.dart';

class ApiService {

  static const _baseURL = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseURL/categories.php'));
    final data = json.decode(response.body);
    return (data['categories'] as List)
        .map((c) => Category.fromJson(c))
        .toList();
  }

  Future<List<Meal>> fetchMeals(String category) async { // fetching based on the category chosen
    List<Meal> mealList = [];
    final response = await http.get(Uri.parse('$_baseURL/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final detailData = json.decode(response.body)['meals'];
      for (int i = 0; i < detailData.length; i++){
        mealList.add(Meal.fromJson(detailData[i]));
      }
    }
    return mealList;
  }

  Future<List<Meal>> searchMeals(String query) async { // searching meals in the category
    final res = await http.get(Uri.parse('$_baseURL/search.php?s=$query'));
    final data = json.decode(res.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List)
        .map((c) => Meal.fromJson(c))
        .toList();
  }

  Future<Details> fetchDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseURL/lookup.php?i=$id'));
    final data = json.decode(response.body);
    return Details.fromJson(data['meals'][0]);
  }

  Future<Details> fetchRandom() async {
    final response = await http.get(Uri.parse('$_baseURL/random.php'));
    final data = json.decode(response.body);
    return Details.fromJson(data['meals'][0]);
  }

}
