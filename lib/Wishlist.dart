import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'Home/widgets/FoodDetail.dart';


class Wishlist extends StatelessWidget{
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'),centerTitle: true,),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: ((BuildContext ctx, index){
          return Container(
margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
child: Container(
 decoration:  BoxDecoration(
  
      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                         topRight:Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                       
                      ), 
  
        color: Theme.of(context).cardTheme.color,
  
    ),


  child:   Column(children: [
  
    Row(
  
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
      children: [
  
      SizedBox(width: MediaQuery.of(context).size.width*0.20,),
  
      RatingBar.builder(
  
        itemSize: 15,
  
     initialRating: 2.5,
  
     minRating: 1,
  
     direction: Axis.horizontal,
  
     allowHalfRating: true,
  
     itemCount: 5,
  
     itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  
     itemBuilder: (context, _) => const Icon(
  
       Icons.star,
  
       color: Color(0xffffb800),
  
       size: 10,
  
     ),
  
     onRatingUpdate: (rating) {
  
     
  
     },
  
  ),
  
  Container(
  
       decoration: const BoxDecoration(
  
      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
  
      topRight:Radius.circular(15) ),  
  
        color:   Colors.red,
  
    ),
  
  height: 25,
  
  width: 37,
  
  child:const Icon(
  
       Icons.remove,
  
       color: Colors.white,
  
       size: 18,
  
     ),)
  
    ],),
  
   fooddetails( context)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ],),
),
          );
        }))
    );
  }
}



  fooddetails(BuildContext context){
    return  
              SizedBox(
                height: 120,
              
                child: Stack(children: [
                   SizedBox(
                     height: 150,
                      width: MediaQuery.of(context).size.width,
                   ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: (() {
                        var foodModel;
                        Navigator.of(context)
                            .push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              FoodDetail(
                            food: foodModel,
                          ),
                        ));
                      }),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
  imageUrl: "https://cdn.britannica.com/50/80550-050-5D392AC7/Scoops-kinds-ice-cream.jpg",
  imageBuilder: (context, imageProvider) => Container(
    height: 100,
    width: 100,
     decoration: const BoxDecoration(
                       
                          shape: BoxShape.circle,
                         
                        ),
   
  ),
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
),
                       
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: MediaQuery.of(context).size.width*.35,
                    child: SizedBox(
                     
                      child: Column(
                        children: [
                         
                          SizedBox(
                            child: Column(children:  [
                              Text('Fries',
                              style: TextStyle(fontWeight: FontWeight.bold,
                               
                                      fontSize: 13,
                                      color: Theme.of(context).textTheme.bodyText1?.color
                                  
                              ),),
                              const SizedBox(height: 10,),
                               
                              
                            ],)
                          ),
                         
          

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

                Positioned(
                   top: 30,
                    left: MediaQuery.of(context).size.width*.35,
                  child:  SizedBox(
                  
                    height: 150,
                    width: 200,
                    child: Text('Lorem ipsum is a name for aa common type of placeholder texta common type of placeholder texta common type of placeholder texta common type of placeholder texta common type of placeholder textcommon type of placeholder text.sense text that still gives an idea of what real words will look like in the final product',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Theme.of(context).textTheme.bodyText1?.color
                                    ),
                                    ),
                  ),
                ),
Positioned(
  left:MediaQuery.of(context).size.width*.3,
  bottom: 0,
  child:   GestureDetector(
  
                                  // onTap: () {
  
                                  //   var cartitems = Provider
  
                                  //           .of<CartItems>(
  
                                  //               context,
  
                                  //               listen: false)
  
                                  //       .items
  
                                  //       .containsKey(_id);
  
                                  //   if (!cartitems) {
  
                                  //     Provider.of<CartItems>(
  
                                  //             context,
  
                                  //             listen: false)
  
                                  //         .addItem(
  
                                  //             foodModel[
  
                                  //                 index],
  
                                  //             _id);
  
                                  //   } else {
  
                                  //     null;
  
                                  //   }
  
                                  // },
  
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    padding:
  
                                        const EdgeInsets.all(
  
                                            5),
  
                                    height: 30,
  
                                    width: 70,
  
                                    decoration:
  
                                        const BoxDecoration(
  
                                      color:
  
                                          Color(0xffffb800),
  
                                      borderRadius:
  
                                          BorderRadius.all(
  
                                        Radius.circular(5.0),
  
                                      ),
  
                                    ),
  
                                    child: const Center(
  
                                      child: Text(
  
                                        // quantity == null
  
                                        //     ? 'Add To Cart'
  
                                        //     : quantity
  
                                        //         .toString(),
  
                                        'Add to',
  
                                        style:
  
                                            TextStyle(
  
                                                color: Colors
  
                                                    .black,
  
                                                fontSize: 12),
  
                                      ),
  
                                    ),
  
                                  ),
  
                                ),
),








                ]),
              );
          
  }
