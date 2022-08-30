
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Providers/Ordersprovider.dart';
import 'package:provider/provider.dart';

import 'Models/Ordermodel.dart';
import 'Providers/Utilityprovider.dart';

class OrderItem extends StatefulWidget{
  final OrderModel order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
   var _isloading = false;
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
             Text('Order No: ${widget.order.orderNumber}',
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
          
          color: Theme.of(context).textTheme.bodyText1?.color),
          ),
           const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            
             Text('Order Date: ${orderdate (widget.order.dateTime)}',
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
             orderstaus(cancelled: widget.order.cancelled, delivered: widget.order.delivered, ontransit: widget.order.ontransit)
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
    itemCount: widget.order.foods.length,
    itemBuilder:((context, index) {
    return  SizedBox(
    
      child: Row(
   children: [
     CachedNetworkImage(
  imageUrl:widget.order.foods[index].image ,
  imageBuilder: (context, imageProvider) => Container(
    height: 60,
    width: 60,
    margin: const EdgeInsets.all(10),
     decoration:  BoxDecoration(
                     
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: imageProvider,
          fit: BoxFit.cover,),
                         
                        ),
   
  ),
  placeholder: (context, url) =>  CircularProgressIndicator(color: Theme.of(context).cardTheme.color,
  strokeWidth: 1.0,),
  errorWidget: (context, url, error) => Container(
   height: 60,
    width: 60,

    margin: const EdgeInsets.all(10),
  child: const Icon(Icons.error)),
),

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  
  Row(
    children:  [
    Text(widget.order.foods[index].title,style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1?.color,),),
  
     
  ],),
  const SizedBox(height: 10,),
    Text('Qty: ${widget.order.foods[index].quantity.toString()}',
    style: TextStyle(
      
      fontSize: 10,
      color:Theme.of(context).textTheme.bodyText1?.color,),
   ),
   const SizedBox(height: 10,),
   Text((int.parse(widget.order.foods[index].price)* widget.order.foods[index].quantity).toString(),
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
                 Text('Mpesa ***${widget.order.phoneNumber?.substring(7,10)}',style: TextStyle(fontSize: 11, color:  Theme.of(context).textTheme.bodyText1?.color,),),
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
                
                     Text(widget.order.address,
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

     Text('Ksh ${widget.order.totalPrice}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 11, ),),
    ],
  ),
  const SizedBox(height: 15,),



  if(_isloading)
 Center(
   child: CircularProgressIndicator(color: Theme.of(context).iconTheme.color,
            strokeWidth: 1.0),
 ),
   
 if (!widget.order.ontransit && !widget.order.delivered && !widget.order.cancelled && !_isloading)  InkWell(
                    onTap:(){
                       setState(() {
                   _isloading =true;

                  }); 
                      Provider.of<OrdersProvider>(context,listen: false).cancelorder(ordernumber:widget.order.orderNumber,
                      id:widget.order.id,
                      context: context,
                      ).whenComplete(() {
 if(mounted){                         setState(() {
                   _isloading = false;

                  });  }
                      });
                    },
                   
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          ' Cancel Order',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),),
          













          ],

        ),
      ),
    );}}