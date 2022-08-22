import 'package:flutter/material.dart';
import 'package:foodie/Providers/Ordersprovider.dart';
import 'package:provider/provider.dart';
import '../Providers/AddressesProvider.dart';


class Addresses extends StatelessWidget{
  const Addresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _addresses = Provider.of<AddressesProvider>(context).addresses;
    return Scaffold(

      appBar: AppBar(),
      body: ListView.builder(
     
        itemCount: _addresses.length ,
        itemBuilder: ((context, ind) {

          var _locations = _addresses[ind].locations;
        return SizedBox(
          
          child: Column(
            children: [
           Container(
            
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    
                    color: Color(0xffFFDB84),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                 child: 
         Center(
          child: Text(
                     _addresses[ind].region,      
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,          
                        ),
          
                      ),
        ), 
          ),
        
         SizedBox(height: MediaQuery.of(context).size.height * .6,
        
        
        

child: 
 ListView.builder(
   itemCount:_locations.length,
   itemBuilder: ((context,index) => SizedBox(
     height: 40,
     child: Container(
                  margin: const EdgeInsets.only(left:20,top: 10,),
       child: Text(_locations[index],
       style: TextStyle(fontSize: 12,
       
       color: Theme.of(context).textTheme.bodyText1?.color),
       ),
     ),
   )),
 ),

        )
            ],
          ),
        );
      })),
    );}}












         
        