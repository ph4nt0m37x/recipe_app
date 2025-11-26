class Meal {

  String name;
  String img;
  String id;

  Meal({required this.name, required this.img, required this.id});

  Meal.fromJson(Map<String, dynamic> data)
      : name = data['strMeal'],
        img = data['strMealThumb'],
        id = data['idCategory'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'img' : img,
    'id' : id,
  };

}