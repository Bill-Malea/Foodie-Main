import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/Models/AddressModel.dart';
import 'package:http/http.dart' as http;
class AddressesProvider extends ChangeNotifier {
List<AddressModel> _addresses = [];

  List<AddressModel> get addresses {
    return _addresses;
  }


 fetchaddresses() async {
  var token = await  FirebaseAppCheck.instance.getToken();
    const url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Addresses/.json';
    try {
        var response = await http.get( Uri.parse(url), 
        headers: {"X-Firebase-AppCheck":token!},
        );
     jsonDecode(response.body).forEach((id, _data) {
            
          List<AddressModel> rawdata = [];
List<String> _locations = [];

for (var item in _data['Locations']) {
    if (kDebugMode) {
               print(item['Name']);
             }
  _locations.add(item['Name']); 
}


rawdata.add(
  AddressModel(
    locations: _locations, 
    region: _data['Region'],
    )); 
    
    _addresses = rawdata;
    notifyListeners();
    });  

    }catch(e){
if (kDebugMode) {
  print('fgf6464ggfgfghf$e');
}
    }
 }





}

