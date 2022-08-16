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
factory OrderModel.fromJson(Map<String, Object> json) {
    return OrderModel(
      address: json['address'].toString(),
      dateTime: '',
      foods: [],
      nameCustomer: '',
     orderNumber: '',
      orderStatus: '',
       phoneNumber: '',
       prefences: '',
        totalPrice: '',
        );
  }
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
