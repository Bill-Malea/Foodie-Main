import 'package:flutter/material.dart';
import 'package:foodie/Orderslist.dart';
import 'package:foodie/Providers/Ordersprovider.dart';
import 'package:provider/provider.dart';

import 'Providers/Utilityprovider.dart';

class OrderPage extends StatelessWidget{
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var orders = Provider.of<OrdersProvider>(context).orders.reversed.toList();
    return Scaffold(

      appBar: AppBar(),
      body: Container(
  color:Theme.of(context).cardTheme.color,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
           
          itemCount: orders.length ,
          itemBuilder: ((context, index) {
          return SizedBox(
            height: 70,
            child: InkWell(
              onTap: () {
                 Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder:
                                (BuildContext context) =>
                                     OrderItem (order: orders[index],)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text('Order No: ${orders[index].orderNumber}',
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
              
              color: Theme.of(context).textTheme.bodyText1?.color),
              ),
               const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                
                 Text('Order Date: ${orderdate (orders[index].dateTime)}',
              style: TextStyle(fontSize: 11,
              color: Theme.of(context).textTheme.caption?.color ),
              ),
              Row(
                children:  [
                   Text('Status',
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
                  color:  Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  ),
                  const SizedBox(width: 10,),
                    orderstaus(cancelled: orders[index].cancelled, 
                    delivered:  orders[index].delivered, 
                    ontransit:  orders[index].ontransit),
                const SizedBox(width: 10,),
                const Icon(Icons.arrow_forward_ios,size: 12,)
                      
                      
                      
                ],
              ),
              
              ],),
              const SizedBox(height:5),
                     // const Divider(thickness: 1.0,color: Colors.black12,),


               
              ],),
            ),
          );
        })),
      ),
    );}}
