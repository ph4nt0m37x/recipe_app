class Category {

  String id;
  String name;
  String img;
  String desc;

  Category({required this.id, required this.name, required this.img, required this.desc});

  Category.fromJson(Map<String, dynamic> data)
  : id = data['idCategory'],
  name = data['strCategory'],
  img = data['strCategoryThumb'],
  desc = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'img' : img,
    'desc' : desc
  };

}