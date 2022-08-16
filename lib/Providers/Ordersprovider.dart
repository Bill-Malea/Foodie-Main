
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/Models/Ordermodel.dart';
import 'package:foodie/Models/foodModel.dart';

import '../Utilities/Themes.dart';

class OrdersProvider extends ChangeNotifier {

  var user = FirebaseAuth.instance;
  var dio = Dio();

 List<OrderModel> _orders = [ ];
  List<OrderModel> get orders {
    return [..._orders];
  }





  loadorders() async {
    var url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Orders/${user.currentUser?.uid}.json';
    try {
        var response = await dio.get(url);



var  data = response.data;

List<OrderModel>  raworderlist =[];

data.forEach((ordernumber,order){



  /////////////////////////////////
order.forEach((id, orderdetails){
 List<FoodModel> foods = [];
for (var food in orderdetails['Items']) {
  foods.add(FoodModel(
  image: food['image']??'',
  id: food['id']??'', 
  title:food['title']??'', 
  description: food['description']??'', 
  typeFood: '', 
  timeFood: '', 
  price: food['price']??'', 
  category: 'category', 
  quantity: food['quantity']??'',
  ),);}

if (kDebugMode) {
   print(order);
  print(orderdetails['TotalPrice'].toString());
}
 raworderlist.add(
OrderModel(
address:orderdetails['Delivery Address']??'' , 
totalPrice: orderdetails['TotalPrice']??'', 
prefences: orderdetails['Preferences']??'', 
dateTime: orderdetails['Date']??'',
foods:foods,
nameCustomer: 'hghjjg',
orderNumber: ordernumber??'',
orderStatus:orderdetails['Orderstatus']??'',
phoneNumber: orderdetails['Phonenumber']??'',
   
   ));


}







);





_orders = raworderlist;
notifyListeners();


} );
     
    } on SocketException {
     errorToast("Check Your Internet Connection and Try again");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

























}
