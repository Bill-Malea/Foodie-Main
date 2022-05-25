import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Models/Ordermodel.dart';

import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:http/http.dart' as http;
import '../Models/foodModel.dart';

class CartItems extends ChangeNotifier {
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

  void addItem(FoodModel food, String id) {
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
          desc: existingCartItem.desc,
          ingredients: existingCartItem.ingredients,
          nutrition: existingCartItem.nutrition,
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
          desc: food.desc,
          image: food.image,
          ingredients: food.ingredients,
          nutrition: food.nutrition,
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
                desc: '',
                category: '',
                image: '',
                ingredients: '',
                nutrition: '',
                timeFood: '',
                typeFood: '',
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

  Future<void> placeorder(
      OrderModel order, BuildContext context) async {
    try {
      Uri _uri = Uri.parse(
          "https://foodie-test-9da37-default-rtdb.firebaseio.com/Orders.json");
      await http
          .post(_uri,
              body: jsonEncode({
                "Ordernumber": order.orderNumber,
                "Delivery Address": order.address,
                "Date": order.dateTime.toIso8601String(),
                "Phonenumber": order.phoneNumber,
                "TotalPrice": order.totalPrice,
                "DeliveryGuy": "",
                "DeliveryphoneNumber": "",
                "Paid": false,
              }))
          .then((value) {
        if (value.statusCode == 200) {
        } else {
          if (kDebugMode) {
            print(
                '=================Errror Place Order${value.body}');
          }
        }
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

  Future<void> processpayment({
    required String userPhone,
    required double amount,
    required BuildContext context,
  }) async {
    dynamic transactionInitialisation;
    Uri _uri = Uri.parse(
        "https://foodie-test-9da37-default-rtdb.firebaseio.com/Mpesa.json");

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

      var payload = {
        'CheckoutRequestID':
            transactionInitialisation["CheckoutRequestID"]
      };
      if (transactionInitialisation["ResponseCode"] ==
          '0') {
        var _result = await http.post(
            Uri.parse(
                "https://foodie-test-9da37-default-rtdb.firebaseio.com/CheckoutRequestID.json"),
            body: jsonEncode(payload));
        if (kDebugMode) {
          print('==================${_result.statusCode}');
          print('==================${_result.body}');
        }
      }

      return transactionInitialisation;
    } on SocketException {
      Navigator.of(context).pop();

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
  }
}
