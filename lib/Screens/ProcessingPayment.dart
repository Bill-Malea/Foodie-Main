import 'package:flutter/material.dart';

import 'package:foodie/Models/Ordermodel.dart';
import 'package:foodie/Orderpage.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:provider/provider.dart';

import '../Orderslist.dart';

class FetchPayment extends StatefulWidget{
  final OrderModel order;
  const FetchPayment({Key? key, required this.order}) : super(key: key);

  @override
  State<FetchPayment> createState() => _FetchPaymentState();
}

class _FetchPaymentState extends State<FetchPayment> {
  @override
  
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor ,
body:FutureBuilder(

          future:    Provider.of<CartItems>(
                      context,
                      listen: false,
                    ).getpaymentdetails(context: context,order: widget.order),
          builder: ((context, snapshot) {
          if(snapshot.hasData) {
              if(snapshot.data == true) {
                    Provider.of<CartItems>(
                      context,
                      listen: false,
                    ).placeorder(context: context, order: widget.order);          
              }
          }else if(snapshot.hasError){
           
 Center(
  child:   Text('An Error Occured ${snapshot.error.toString()}'),
);

          }


 return 
 Center(
  child:   CircularProgressIndicator(strokeWidth: 1,
  color: Theme.of(context).iconTheme.color,)
);


          }
)));
  }}




