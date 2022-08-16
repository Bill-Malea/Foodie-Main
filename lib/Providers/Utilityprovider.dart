// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:foodie/Utilities/Themes.dart';
import 'package:hive/hive.dart';
class Utilityprovider extends ChangeNotifier {

var uid = FirebaseAuth.instance.currentUser?.uid;
List<FoodModel> _favourites = [];
List<FoodModel> favouriteslist(){
  return _favourites;
}




 favourites() async{
final wishlist =  Hive.openBox('Wishlist$uid');
  List<FoodModel> rawmodel =[];
 var list = await wishlist;

var fav =  list.values;

 for (var item in fav) { 

rawmodel.add(FoodModel(
     image: item['image']??'',
     id: item['id']??'', 
     title: item['title']??'',
     description: item['description']??'',
     typeFood: item['typeFood']??'', 
     timeFood: item['timeFood']??'', 
     price: item['price']??'', 
     category: item['category']??'', 
     quantity: item['quantity']??'',));
 }
_favourites = rawmodel;
notifyListeners();

}
Future<bool>  favouritess(String id) async{ 
var favor = await Hive.openBox<bool>('favourites$id');

 var favourite =  favor.get(id);
 return favourite??false;
  }

  final List<bool> _selectedtab = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];

  int get selectetab => _select;

  List<bool> get selected => _selectedtab;

  int _select = 0;

  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i != n) {
        _selectedtab[i] = false;
        _select = n;
      } else {
        _selectedtab[i] = true;
      }
      notifyListeners();
    }
  }




savefavourite(FoodModel food) async{
final list =  Hive.openBox('Wishlist$uid');
 var wishlist = await list;
var favor = await Hive.openBox<bool>('favourites${food.id}');

var payload = {
'title':food.title,
'rating': food.quantity,
'description':food.description,
'image':food.image,
'id':food.id,
'price':food.price,
'category':food.category,
'quantity':food.quantity,
'typeFood':food.typeFood,
'timeFood':food.timeFood
  };

 // update favourite hive box status 
   await favor.put(food.id, true);
   favourite(food.id);
  //add favourite foodmodel  to wishlist
 await wishlist.put(food.id, payload); 
  // notify listeners
await await favourites();
notifyListeners();
}


 favourite(String id)async{
var favor = await Hive.openBox<bool>('favourites$id');
 var favourite =  favor.get(id);
 if(favourite == null ||favourite == false ){
    favor.put(id, false);
    errorToast('Removed from Favourites');
   notifyListeners();
 }   else {
       favor.put(id, true);
       sucessToast('Added to Favourites');
      notifyListeners();
 }


 
}


removefavourite(String id) async{

final list =  Hive.openBox('Wishlist$uid');
var wishlist = await list;
var favor = await Hive.openBox<bool>('favourites$id');
//remove fooditem from wishlist
wishlist.delete(id);
//update favourite status
 favor.put(id, false);
  //
favourite(id);
///reload the list to show changes
await favourites();
////////////////
notifyListeners();
}

}
