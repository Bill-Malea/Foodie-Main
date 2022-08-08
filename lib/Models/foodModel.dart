// ignore: file_names
class FoodModel {
  String id;
  String image;
  String title;
  String description;
  String typeFood;
  String timeFood;
  String price;
  
  String category;
  int quantity;



    Map<String, dynamic> toMap(){
      return {
  'id':id,
  'image':image,
  'title':title,
  'price':price,  
  'quantity':quantity,
      };

}
  FoodModel(
      {required this.image,
      required this.id,
      required this.title,
      required this.description,
      required this.typeFood,
      required this.timeFood,
      required this.price,
      required this.category,
      required this.quantity});
}
