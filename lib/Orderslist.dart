
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Models/Ordermodel.dart';

class OrderItem extends StatelessWidget{
  final OrderModel order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   


    return Scaffold(

appBar: AppBar(),
      body: Container(
        color: Theme.of(context).cardTheme.color,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 10,),
             Text('Order No: ${order.orderNumber}',
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
          
          color: Theme.of(context).textTheme.bodyText1?.color),
          ),
           const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            
             Text('Order Date: Jun 20,2022',
          style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.caption?.color ),
          ),
          Row(
            children:  [
               Text('Status',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
              color:  Theme.of(context).textTheme.bodyText1?.color,
              ),
              ),
              const SizedBox(width: 10,),
              Container(
                padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
  
             borderRadius: BorderRadius.all(Radius.circular(5)),  
             
  
        color:   Colors.greenAccent,
  
    ),
  
  height: 25,
  
  width: 70,
  child:  const Text('Delivered',style: TextStyle(color: Colors.black,)),
              )
            ],
          ),
          
          ],),
          const SizedBox(height:5),
          const Divider(thickness: 1.0,color: Colors.black12,),

//order list
SizedBox(
  height: MediaQuery.of(context).size.height*.4,
  child: SizedBox(
  child: ListView.builder(
    itemCount: order.foods.length,
    itemBuilder:((context, index) {
    return  SizedBox(
    
      child: Row(
   children: [
     CachedNetworkImage(
  imageUrl: "https://cdn.britannica.com/50/80550-050-5D392AC7/Scoops-kinds-ice-cream.jpg",
  imageBuilder: (context, imageProvider) => Container(
    height: 60,
    width: 60,
    margin: const EdgeInsets.all(10),
     decoration:  BoxDecoration(
                       color: Colors.red,
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: imageProvider,
          fit: BoxFit.cover,),
                         
                        ),
   
  ),
  placeholder: (context, url) =>  CircularProgressIndicator(color: Theme.of(context).cardTheme.color,
  strokeWidth: 1.0,),
  errorWidget: (context, url, error) => const Icon(Icons.error),
),

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  
  Row(
    children:  [
    Text(order.foods[index].title,style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1?.color,),),
  
     
  ],),
  const SizedBox(height: 10,),
    Text('Qty: ${order.foods[index].quantity.toString()}',
    style: TextStyle(
      
      fontSize: 10,
      color:Theme.of(context).textTheme.bodyText1?.color,),
   ),
   const SizedBox(height: 10,),
   Text((int.parse(order.foods[index].price)* order.foods[index].quantity).toString(),
    style: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1?.color,),
    
    ),
   
],)
   ],


   
      ),
    );
  })),
)),

          const Divider(thickness: 1.0,color: Colors.black12,),
          Padding(
            padding: const EdgeInsets.only(left:10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                 Text('Payment',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
                   Text('Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                 Text('Mpesa ****',style: TextStyle(fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
                   Text('Address',style: TextStyle(fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            
            child: Padding(
              padding: const EdgeInsets.only(left:10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                
                     Text(order.address,
                     style: const TextStyle(fontSize: 11,color: Colors.black54),
                     maxLines: 3,
                  
                     ),
                ],
              ),
            ),
          ),

const SizedBox(height: 10,),
 const Divider(thickness: 1.0,color: Colors.black12,),
 Text('Order Summary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
 const SizedBox(height: 15,),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     Text('Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,  color:  Theme.of(context).textTheme.bodyText1?.color,),),

     Text('Ksh ${order.totalPrice}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 11, ),),
    ],
  ),
  const SizedBox(height: 15,),

          
          ],

        ),
      ),
    );}}