// ignore: file_names
class FoodModel {
  String id;
  String image;
  String title;
  String desc;
  String typeFood;
  String timeFood;
  String price;
  String ingredients;
  String nutrition;
  String category;
  int quantity;

  FoodModel(
      {required this.image,
      required this.id,
      required this.title,
      required this.desc,
      required this.typeFood,
      required this.timeFood,
      required this.price,
      required this.ingredients,
      required this.nutrition,
      required this.category,
      required this.quantity});
}
