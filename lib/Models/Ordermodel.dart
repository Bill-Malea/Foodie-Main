import 'package:foodie/Models/foodModel.dart';

class OrderModel {
  String orderNumber;
  String totalPrice;

  String address;
  String? phoneNumber;
  String? nameCustomer;
  String orderStatus;
  String dateTime;
  List<FoodModel> foods;
   String prefences;

  OrderModel( {
      required this.orderNumber,
      required this.totalPrice,
      required this.prefences,
      required this.foods,
      required this.address,
      required this.phoneNumber,
      required this.nameCustomer,
      required this.orderStatus,
      required this.dateTime});
}
