import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/Models/AddressModel.dart';
import 'package:http/http.dart' as http;
class AddressesProvider extends ChangeNotifier {
    var user = FirebaseAuth.instance.currentUser;
List<AddressModel> _addresses = [];
List<String> _locations = [];
 List<String> get locations{
    return _locations;
  }

  List<AddressModel> get addresses {
    return _addresses;
  }


 fetchaddresses() async {

  final _idToken = await user?.getIdToken();
  var token = await  FirebaseAppCheck.instance.getToken();
    var url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Addresses/.json?auth=$_idToken';
    try {
        var response = await http.get( Uri.parse(url), 
        headers: {"X-Firebase-AppCheck":token!},
        );
     jsonDecode(response.body).forEach((id, _data) {
            
          List<AddressModel> rawdata = [];
List<String> _rawlocation = [];

for (var item in _data['Locations']) {
    if (kDebugMode) {
               print(item['Name']);
             }
  _rawlocation.add(item['Name']); 
}


rawdata.add(
  AddressModel(
    locations: _rawlocation, 
    region: _data['Region'],
    )); 
    _locations = _rawlocation;
    _addresses = rawdata;
    notifyListeners();
    });  

    }catch(e){
if (kDebugMode) {
  print('==============+++++FETCH ADDRESES ERRORS$e');
}
    }
 }





}

