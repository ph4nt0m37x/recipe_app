class Details {
  String id;
  String name;
  String instructions;
  String img;
  String link;
  String ingredients;

  Details(
      {required this.id, required this.name, required this.instructions, required this.img,
        required this.link, required this.ingredients});

  Details.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        name = data['strMeal'],
        instructions = data['strInstructions'],
        img = data['strMealThumb'],
        link = data['strYoutube'],
        ingredients = returnIngredients(data);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'instructions': instructions,
        'img' : img,
        'link' : link,
        'ingredients' : ingredients
      };

  static String returnIngredients(Map<String, dynamic> data){

    List<String> ingredientsList = parseDynamically(data, "strIngredient");
    List<String> measureList = parseDynamically(data, "strMeasure");

    var result = "";

    for(int i = 0; i < ingredientsList.length; i++){
      result =  "-" + result + ingredientsList[i] + measureList[i];
      result += ",\n";
    }
    return result;
  }


   static List<String> parseDynamically(Map<String, dynamic> data, text) {
    var list = <String>[];
    data.forEach((key, value) {
      if (key.contains(text) && value != null && value.toString().trim().isNotEmpty) {
        list.add(value.toString());
      }
    });
    return list;
  }
}