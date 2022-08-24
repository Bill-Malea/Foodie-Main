import 'dart:convert';
import 'dart:io';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:http/http.dart' as http;
import '../Utilities/Themes.dart';

class FoodsProvider extends ChangeNotifier {

 
  late List<FoodModel> _chicken = [];
   List<FoodModel> _juice = [];
  List<FoodModel> _fries = [];
 List<FoodModel> _allfoods = [ ];
  List<FoodModel> get allfoods {
    return [..._allfoods];
  }

  List<FoodModel> _icecream = [ ];

  List<FoodModel> get iceCream {
    return [..._icecream];
  }

 List<FoodModel> get fries {
    return [..._fries];
  }

 List<FoodModel> get chicken {
    return [..._chicken];
  }
  
 List<FoodModel> get juice {
    return [..._juice];
  }





  loadfoods() async {
var token = await  FirebaseAppCheck.instance.getToken();

    var url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Foods/.json';

    if (token != null) {
       

 try {
        var response = await http.get(Uri.parse(url),
        headers: {"X-Firebase-AppCheck":token},
        );
      
      if (response.statusCode == 200) {
              
        List<FoodModel> sub = [];
         List<FoodModel> ice = [];
          List<FoodModel> fry = [];
           List<FoodModel> chic = [];
            List<FoodModel> drink = [];
       jsonDecode(response.body).forEach((id, _data) {
         
         _data['Subcategories'].forEach(


          

          (dataid, subcategory){
      sub.add(FoodModel(
            id: dataid,
            title: subcategory["Name"]??'', 
            description: subcategory["Description"]??'', 
            image:subcategory["Image"]??'', 
            price:subcategory["Price"]??'',
             category: 'ffxfx', 
            quantity: 0, 
            timeFood: '25',
            typeFood:_data['Name']??'' ,
          ));
            _allfoods = sub;

          notifyListeners();
         
var category = _data['Name'].toString().trim().toLowerCase(); 

if( category == 'fries'){
fry.add(FoodModel(
            id: dataid,
            title: subcategory["Name"]??'', 
            description: subcategory["Description"]??'', 
            image:subcategory["Image"]??'', 
            price:subcategory["Price"]??'',
             category: _data['Name']??'', 
            quantity: 0, 
            timeFood: '25',
            typeFood:_data['Name']??'' ,
          ));
           
          _fries= fry;

          notifyListeners();
}else if( category == 'icecream'){

ice.add(FoodModel(
            id: dataid,
            title: subcategory["Name"]??'', 
            description: subcategory["Description"]??'', 
            image:subcategory["Image"]??'', 
            price:subcategory["Price"]??'',
             category:  _data['Name']??'', 
            quantity: 0, 
            timeFood: '25',
            typeFood:_data['Name']??'' ,
          ));
           
          _icecream = ice;

          notifyListeners();



}
else if( category == 'chicken'){

chic.add(FoodModel(
            id: dataid,
            title: subcategory["Name"]??'', 
            description: subcategory["Description"]??'', 
            image:subcategory["Image"]??'', 
            price:subcategory["Price"]??'',
             category:  _data['Name']??'', 
            quantity: 0, 
            timeFood: '25',
            typeFood:_data['Name']??'' ,
          ));
             
          _chicken = chic;

          notifyListeners();



}

else if( category == 'juice'){

drink.add(FoodModel(
            id: dataid,
            title: subcategory["Name"]??'', 
            description: subcategory["Description"]??'', 
            image:subcategory["Image"]??'', 
            price:subcategory["Price"]??'',
             category:  _data['Name']??'', 
            quantity: 0, 
            timeFood:  _data['Timefood']??'',
            typeFood:_data['Name']??'' ,
          ));
                   _juice = drink;

          notifyListeners();

}
      
          }
         );
        
        
        });
      } else {
        errorToast(json.decode( response.body.toString()));
      }
    } on SocketException {
     errorToast("Check Your Internet Connection and Try again");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }















    } else {
       if (kDebugMode) {
        print('Error: couldnt get an App Check token');
      }
        // Error: couldn't get an App Check token.
    }
   
  }

}
