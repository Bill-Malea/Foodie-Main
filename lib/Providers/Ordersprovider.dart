import 'dart:convert';
import 'dart:io';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/Models/Ordermodel.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:http/http.dart' as http;
import '../Utilities/Themes.dart';

class OrdersProvider extends ChangeNotifier {

  var user = FirebaseAuth.instance;


 List<OrderModel> _orders = [ ];
  List<OrderModel> get orders {
    return [..._orders];
  }





  loadorders() async {
     var token = await  FirebaseAppCheck.instance.getToken();
    var url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Orders/${user.currentUser?.uid}.json';

    try {
        var response = await http.get( Uri.parse(url),
      headers: {"X-Firebase-AppCheck":token!},
        );



var  data =  jsonDecode(response.body);

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
