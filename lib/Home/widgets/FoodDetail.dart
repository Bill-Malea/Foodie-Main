import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:foodie/Providers/Utilityprovider.dart';
import 'package:provider/provider.dart';

import '../../Providers/Cartprovider.dart';

class FoodDetail extends StatefulWidget {
  final FoodModel food;
  const FoodDetail({Key? key, required this.food})
      : super(key: key);

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {

// ignore: prefer_typing_uninitialized_variables
var  isfavourite;

  @override
  Widget build(BuildContext context) {

  Provider.of< Utilityprovider>(context).favouritess(widget.food.id).then((value) {
    setState(() {
      isfavourite = value;
    });
  });
 favourite () async{


  if(!isfavourite){
Provider.of<Utilityprovider>(context,listen: false).savefavourite(widget.food);
  }  else {
    Provider.of<Utilityprovider>(context,listen: false).removefavourite(widget.food.id);   
  }

 
}
     var quantity = Provider.of<CartItems>(context)
                .itemquantity(widget.food.id);
    return Scaffold(
        body: Column(
      children: [
        Topimage(food: widget.food, isfavourite: isfavourite ?? false,fn: favourite,),
        SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.food.title,
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .color,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: (() {
                            if (widget.food.quantity > 1) {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .removeSingleItem(
                                      widget.food.id);
                            } else {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .removeItem(widget.food.id);
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
                            var cartitems =
                                Provider.of<CartItems>(
                                        context,
                                        listen: false)
                                    .items
                                    .containsKey(widget.food.id);
                            if (!cartitems) {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .addItem(widget.food, widget.food.id);
                            } else {
                              null;
                            }
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.all(5),
                            height: 30,
                            width: 70,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFDB84),
                              borderRadius:
                                  BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                               
                                 quantity== null ? '0':
                                      quantity.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
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
                          
                            Provider.of<CartItems>(context,
                                    listen: false)
                                .addItem(widget.food, widget.food.id);
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
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Text(
                 widget.food.description,               style:
                      Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 60,
          decoration: const BoxDecoration(
            // color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Ksh',
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color,
                        fontSize: 10,
                      )),
                  Text(widget.food.price,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      )),
                ],
              ),
              InkWell(
                onTap: (() {}),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFDB84),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Proceed To CheckOut',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

// ignore: must_be_immutable
class Topimage extends StatelessWidget {
  bool isfavourite;
  dynamic fn;
   Topimage({ required this.isfavourite,required this.fn,
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: fn,
                  child: !isfavourite ?  const Icon(
                    Icons.favorite_border_rounded,
                    size: 22,
                  ):const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 280,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(food.image),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
