import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:foodie/Providers/Utilityprovider.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget{
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void didChangeDependencies() {
     Provider.of<Utilityprovider>(context,listen: false).favourites();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

   var wishlist =  Provider.of<Utilityprovider>(context).favouriteslist();
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'),centerTitle: true,),
      body: ListView.builder(
        itemCount: wishlist.length,
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
  
       color: Colors.red,
  
       size: 10,
  
     ),
  
     onRatingUpdate: (rating) {
  
     
  
     },
  
  ),
  
  InkWell(
    onTap: (){
      Provider.of<Utilityprovider>(context,listen: false).removefavourite(wishlist[index].id);
    },
    child: Container(
    
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
    
       ),),
  )
  
    ],),
  
   fooddetails( context, wishlist[index])
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ],),
),
          );
        }))
    );
  }
}



  fooddetails(BuildContext context,FoodModel foodModel){
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
                     
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
  imageUrl: "https://cdn.britannica.com/50/80550-050-5D392AC7/Scoops-kinds-ice-cream.jpg",
  imageBuilder: (context, imageProvider) => Container(
    height: 100,
    width: 100,
     decoration:  BoxDecoration(
                       color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: imageProvider,
          fit: BoxFit.cover,),
                         
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
                              Text(foodModel.title,
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
                    child: Text(foodModel.description,
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
  
                                  onTap: () {
  
                                    var cartitems = Provider
  
                                            .of<CartItems>(
  
                                                context,
  
                                                listen: false)
  
                                        .items
  
                                        .containsKey(foodModel.id);
  
                                    if (!cartitems) {
  
                                      Provider.of<CartItems>(
  
                                              context,
  
                                              listen: false)
  
                                          .addItem(foodModel,foodModel.id);
  
                                    } else {
  
                                      null;
  
                                    }
  
                                  },
  
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
                                        'Add to Cart',
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
