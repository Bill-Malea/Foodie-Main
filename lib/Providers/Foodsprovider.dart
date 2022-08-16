import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';

import '../Utilities/Themes.dart';

class FoodsProvider extends ChangeNotifier {
  var dio = Dio();
  late List<FoodModel> _chicken = [];
   List<FoodModel> _juice = [];
  List<FoodModel> _fries = [];

 // ignore: prefer_final_fields
 List<FoodModel> _allfoods = [
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://media.istockphoto.com/photos/diverse-keto-dishes-picture-id1280158821?b=1&k=20&m=1280158821&s=170667a&w=0&h=ibwKxBzWcygq6NMKO5FTD-3ljLvwM8E1WVevw7XSmlk=',
    
   
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '10 Min',
    //   title: 'Fries',
    //   id: 'F100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
    
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '30 Min',
    //   title: 'Smokie',
    //   id: 'S100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://media.istockphoto.com/photos/spicy-deep-fried-breaded-chicken-wings-picture-id583848484?k=20&m=583848484&s=612x612&w=0&h=oS5NY9C48rsgQEoNn-m55kpL4SpkBD5fhsnuEq-xGq4=',
   
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '25 Min',
    //   title: 'Chicken',
    //   id: 'C100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
    
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '15 Min',
    //   title: 'Smokie',
    //   id: 'S200',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
      
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '25 Min',
    //   title: 'Smokie',
    //   id: 'S300',
    // )
  ];
  List<FoodModel> get allfoods {
    return [..._allfoods];
  }

  List<FoodModel> _icecream = [
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image: 'https://wallpapercave.com/wp/jLof3qL.jpg',
     
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '20 Min',
    //   title: 'Vannila',
    //   id: 'V100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image: 'https://wallpaperaccess.com/full/1279270.jpg',
     
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '30 Min',
    //   title: 'Strawberry',
    //   id: 'SI100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://c8.alamy.com/comp/MN6C09/chocolate-and-almond-ice-pops-in-a-cluster-overhead-scene-over-a-slate-background-MN6C09.jpg',
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '20 Min',
    //   title: 'Popsicle',
    //   id: 'P100',
    // ),
    // FoodModel(
    //   category: 'cccc',
    //   typeFood: 'Pizza',
    //   description: 'jhhvvjv',
    //   image:
    //       'https://p4.wallpaperbetter.com/wallpaper/108/450/541/food-ice-cream-berry-blueberry-wallpaper-preview.jpg',
    //   price: '100',
    //   quantity: 2,
    //   timeFood: '30 Min',
    //   title: 'Strawberry',
    //   id: 'SO100',
    // ),
  ];

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
    const url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Foods/.json';
    try {
        var response = await dio.get(url);
      
      if (response.statusCode == 200) {
              
        List<FoodModel> sub = [];
         List<FoodModel> ice = [];
          List<FoodModel> fry = [];
           List<FoodModel> chic = [];
            List<FoodModel> drink = [];
        response.data.forEach((id, _data) {
         
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
        errorToast(response.data.toString());
      }
    } on SocketException {
     errorToast("Check Your Internet Connection and Try again");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

























}
