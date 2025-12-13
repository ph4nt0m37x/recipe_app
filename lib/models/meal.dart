class Meal {

  String name;
  String img;
  String id;
  bool isFavorite;

  Meal({required this.name, required this.img, required this.id, this.isFavorite = false});

  Meal.fromJson(Map<String, dynamic> data)
      : name = data['strMeal'],
        img = data['strMealThumb'],
        id = data['idMeal'],
        isFavorite = false;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'img' : img,
    'id' : id,
    'isFavorite' : isFavorite,
  };

}