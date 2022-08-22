




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/Ordermodel.dart';

// ignore: must_be_immutable
class OrderPaymentScreen extends StatelessWidget{
  final OrderModel order;
    bool isloading;
   OrderPaymentScreen ({Key? key, required this.order,required this.isloading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        color: Theme.of(context).cardTheme.color,
       padding: const EdgeInsets.all(15),
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
  height: MediaQuery.of(context).size.height * 0.45,
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
mainAxisAlignment: MainAxisAlignment.start,
    children:
      [
    Text(order.foods[index].title,style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1?.color,),),
  
    
  ],),
  const SizedBox(height: 10,),
    Text(order.foods[index].quantity.toString() ,
    style: TextStyle(
      
      fontSize: 10,
      color:Theme.of(context).textTheme.bodyText1?.color,),
   ),
    const SizedBox(height: 10,),
    Text('Ksh ${ int.parse(order.foods[index].price) * order.foods[index].quantity }',
    style: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1?.color,),
    
    ),
   const SizedBox(height: 20,)

   
],)

   ],


   
      ),
    );
  })),
),

    
 const Divider(thickness: 1.0,color: Colors.black12,),
  const Text('Order Summary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
 const SizedBox(height: 15,),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:  [
    const Text('Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11, color: Colors.black54),),

     Text('Ksh ${order.totalPrice}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 11, ),),
    ],
  ),   
  
  const SizedBox(height: 20,),
  if(!isloading) GestureDetector(
                
                  
             
         
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(20),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFDB84),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Complete Your Order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
  if(isloading)
  Center(
    child: Column(
      children: [
        CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                    ),
const SizedBox(height: 25,),
            if(isloading)        const Text('Processing payment .......'),
      ],
    ),
  ),
    ],

        ),
      ),
    );}}
