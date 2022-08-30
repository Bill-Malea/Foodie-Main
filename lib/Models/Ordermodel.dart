import 'package:foodie/Models/foodModel.dart';

class OrderModel {
  String id;
  String orderNumber;
  String roomNumber;
  String totalPrice;
  bool paid;
  bool cancelled;
  bool delivered;
  bool ontransit;
  String address;
  String? phoneNumber;
  String? nameCustomer;

  String dateTime;
  List<FoodModel> foods;
   String prefences;
// factory OrderModel.fromJson(Map<String, Object> json) {
//     return OrderModel(
//       address: json['address'].toString(),
//       roomNumber: ,
//       dateTime: '',
//       foods: [],
//       nameCustomer: '',
//        phoneNumber: '',
//        prefences: '',
//         totalPrice: '',
//         paid: false, 
//         delivered: false, 
//         ontransit: false, 
//         orderNumber: '',
//         cancelled: false
//         );
//   }
  OrderModel( {
    required this.id,
      required this.orderNumber,
       required this.roomNumber,
      required this.paid,
        required this.cancelled,
      required this.delivered,
      required this.ontransit,
      required this.totalPrice,
      required this.prefences,
      required this.foods,
      required this.address,
      required this.phoneNumber,
      required this.nameCustomer,
      required this.dateTime});
}
