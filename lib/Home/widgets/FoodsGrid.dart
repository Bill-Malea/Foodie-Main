import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:provider/provider.dart';
import '../../Models/foodModel.dart';
import 'FoodDetail.dart';

class FoodGrid extends StatelessWidget {
  final List<FoodModel> foodModel;
  const FoodGrid({Key? key, required this.foodModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 5),
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63),
          itemCount: foodModel.length,
          itemBuilder: (context, index) {
            var _id = foodModel[index].id;
            var quantity = Provider.of<CartItems>(context)
                .itemquantity(_id);
            return Column(children: [
              SizedBox(
                height: 250,
                width: 200,
                child: Stack(children: [
                  const Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(85),
                        topRight: Radius.circular(85),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: SizedBox(
                      height: 250,
                      width: 180,
                    ),
                  ),
                  Positioned(
                    right: -10,
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.of(context)
                            .push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              FoodDetail(
                            food: foodModel[index],
                          ),
                        ));
                      }),
                      child: Container(
                        
                        height: 150,
                        width: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        
                        ),


                        child: CachedNetworkImage(
  imageUrl: foodModel[index].image,
  imageBuilder: (context, imageProvider) => Container(
  
     decoration:  BoxDecoration(
                       color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: imageProvider,
          fit: BoxFit.cover,),
                         
                        ),
   
  ),
  placeholder: (context, url) => CircularProgressIndicator(color: Theme.of(context).cardTheme.color,
  strokeWidth: 1.0),
  errorWidget: (context, url, error) => const Icon(Icons.error),
),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 120,
                      width: 175,
                      child: Column(
                
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Text(
                                  foodModel[index].title,
                                  textAlign:
                                      TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    // color: Color(0xff544646),
                                    fontSize: 15,
                                  ),
                                ),
                              
                                Row(
                                  children: [
                                    Text(
                                      'Ksh',
                                      textAlign:
                                          TextAlign.center,
                                      style:
                                          Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                    ),
                                    Text(
                                      foodModel[index]
                                          .price,
                                      textAlign:
                                          TextAlign.center,
                                      style:
                                          const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 40,
                          )),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 2,
                              ),
                              GestureDetector(
                                onTap: (() {
                                  if (quantity! > 1) {
                                    Provider.of<CartItems>(
                                            context,
                                            listen: false)
                                        .removeSingleItem(
                                            foodModel[index]
                                                .id);
                                  } else {
                                    Provider.of<CartItems>(
                                            context,
                                            listen: false)
                                        .removeItem(
                                            foodModel[index]
                                                .id);
                                  }
                                }),
                                child: Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  var cartitems = Provider
                                          .of<CartItems>(
                                              context,
                                              listen: false)
                                      .items
                                      .containsKey(_id);
                                  if (!cartitems) {
                                    Provider.of<CartItems>(
                                            context,
                                            listen: false)
                                        .addItem(
                                            foodModel[
                                                index],
                                            _id);
                                  } else {
                                    null;
                                  }
                                },
                                child: Container(
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
                                  child: Center(
                                    child: Text(
                                      quantity == null
                                          ? 'Add To Cart'
                                          : quantity
                                              .toString(),
                                      style:
                                          const TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: (() {
                                  Provider.of<CartItems>(
                                          context,
                                          listen: false)
                                      .addItem(
                                          foodModel[index],
                                          foodModel[index]
                                              .id);
                                }),
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ]);
          }),
    );
  }
}
