

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/Models/AddressModel.dart';

class AddressesProvider extends ChangeNotifier {
 var dio = Dio();
List<AddressModel> _addresses = [];

  List<AddressModel> get addresses {
    return _addresses;
  }


 fetchaddresses() async {
    const url = 'https://foodie-test-9da37-default-rtdb.firebaseio.com/Addresses/.json';
    try {
        var response = await dio.get(url);
          response.data.forEach((id, _data) {
            
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

