import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:provider/provider.dart';

import '../../Providers/Cartprovider.dart';

class FoodDetail extends StatelessWidget {
  final FoodModel food;
  const FoodDetail({Key? key, required this.food})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Topimage(food: food),
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
                      'French Fries',
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
                            if (food.quantity > 1) {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .removeSingleItem(
                                      food.id);
                            } else {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .removeItem(food.id);
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
                                    .containsKey(food.id);
                            if (!cartitems) {
                              Provider.of<CartItems>(
                                      context,
                                      listen: false)
                                  .addItem(food, food.id);
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
                                // ignore: unnecessary_null_comparison
                                food.quantity == null
                                    ? 'Add To Cart'
                                    : food.quantity
                                        .toString(),
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
                                .addItem(food, food.id);
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
                  'French fries are served hot, either soft or crispy, and are generally eaten as part of lunch or dinner or by themselves as a snack, and they commonly appear on the menus of diners, fast food restaurants, pubs, and bars. They are often salted and may be served with ketchup, vinegar, mayonnaise, tomato sauce, or other local specialities. Fries can be topped more heavily, as in the dishes of poutine or chili cheese fries. French fries can be made from sweet potatoes instead of potatoes. A baked variant, oven fries, uses less or no oil.',
                  style:
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
                  Text(food.price,
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

class Topimage extends StatelessWidget {
  const Topimage({
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
            height: 40,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: GestureDetector(
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
                  onTap: (() {}),
                  child: const Icon(
                    Icons.favorite_border_rounded,
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
