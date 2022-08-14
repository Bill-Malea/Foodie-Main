import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Models/Ordermodel.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:http/http.dart' as http;
import '../Models/foodModel.dart';
import '../Screens/Payment.dart';
import '../Utilities/Themes.dart';

class CartItems extends ChangeNotifier {
var user = FirebaseAuth.instance;
Random random = Random();
  Map<String, FoodModel> _items = {};

  List<FoodModel> get cartlist {
    List<FoodModel> _cartlist = [];
    _items.forEach((key, cartItem) {
      _cartlist.add(cartItem);
    });
    return _cartlist;
  }
   

  Map<String, FoodModel> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  int? itemquantity(String productId) {
    var quantity = _items[productId]?.quantity;
    return quantity;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total +=
          int.parse(cartItem.price) * cartItem.quantity;
    });
    return total;
  }



  void addItem(FoodModel food, String id ,) {




    if (_items.containsKey(id)) {
      // change quantity...
      _items.update(
        food.id,
        (existingCartItem) => FoodModel(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          category: existingCartItem.category,
          image: existingCartItem.image,
          description: existingCartItem.description,
          timeFood: existingCartItem.timeFood,
          typeFood: existingCartItem.typeFood,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => FoodModel(
          id: id,
          title: food.title,
          price: food.price,
          quantity: 1,
          typeFood: food.typeFood,
          category: food.category,
          description: food.description,
          image: food.image,
          timeFood: food.timeFood,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => FoodModel(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                description:  existingCartItem.description,
                category:  existingCartItem.category,
                image:  existingCartItem.image,
                timeFood:  existingCartItem.timeFood,
                typeFood:  existingCartItem.typeFood
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future<void> placeorder({
      required OrderModel order, required BuildContext context}) async {
     final uid = user.currentUser?.uid;
   
     List foodsmap =[];
     for (var food in order.foods) { 
     var fooditem = food.toMap();
     foodsmap.add(fooditem);
  }
 
    try {
      Uri _uri = Uri.parse(
          "https://foodie-test-9da37-default-rtdb.firebaseio.com/Orders/$uid/${order.orderNumber}.json");
      await http
          .post(_uri,
              body: jsonEncode({
                "Delivery Address": order.address,
                "Date": order.dateTime,
                "Phonenumber": order.phoneNumber,
                "TotalPrice": order.totalPrice,
                'Preference':order.prefences,
                "DeliveryGuy": "",
                "DeliveryGuyphoneNumber": "",
                'Items': foodsmap ,
                
              }))
          .then((value) {
        if (value.statusCode == 200) {

          Navigator.of(context)
                            .push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              Payment(order: order,),
                        ));
        } else {
          if (kDebugMode) {
            print(
                '=================Errror Place Order${value.body}');
          }
        }
        foodsmap.clear();

      });
    } on SocketException {
      Fluttertoast.showToast(
        msg:
            "Check Your Internet Coonection and Try Again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> processpayment(
    {
    required OrderModel order,
    required BuildContext context, 
    required String userPhone,
  }
  ) async {
   final uid = user.currentUser?.uid;
   
    dynamic transactionInitialisation;
    Uri _uri = Uri.parse(
        "https://ij6uquqt6wp5bo5rpwprmstbsi0bnvwf.lambda-url.us-east-1.on.aws/$uid/${order.orderNumber}");
if (kDebugMode) {
  print('$uid/jkjkjkj//${order.orderNumber}');
}
    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType:
                  TransactionType.CustomerPayBillOnline,
              amount: 1.0,
              partyA: '254727800223',
              partyB: "174379",
              callBackURL: _uri,
              accountReference: "shoe",
              phoneNumber: '254727800223',
              baseUri: Uri(
                  scheme: "https",
                  host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

    
      if (transactionInitialisation["ResponseCode"] ==
          '0') {
        
sucessToast('Enter Mpesa pin to complete payment');
     


      }

    } on SocketException {
  
      errorToast("Check Your Internet Connection and Try Again.");
    } catch (e) {
      
      if (kDebugMode) {
        print("CAUGHT EXCEPTION: " + e.toString());
      }
    }
 return transactionInitialisation["ResponseCode"];
  }
















   Future<bool> getpaymentdetails(
    {
    required OrderModel order,
    required BuildContext context, 
  }
  ) async {
   final uid = user.currentUser?.uid;
   
  
    Uri _uri = Uri.parse(
        "https://7sux3q66vjlwnd7cwzzb4bmqb40rgpsb.lambda-url.us-east-1.on.aws/$uid/${order.orderNumber}");

    try {
     
 var response = await http.get(_uri,);
if (kDebugMode) {
  print(response.statusCode);
   print(response.body);
}
      

    } on SocketException {
      Fluttertoast.showToast(
          msg:
              "Check Your Internet Coonection and Try Again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      //For now, console might be useful
      if (kDebugMode) {
        print("CAUGHT EXCEPTION: " + e.toString());
      }
    }


    return true;

  }
}
