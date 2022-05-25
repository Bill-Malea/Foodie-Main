import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Icons_illustrations.dart';
import 'package:foodie/Models/Ordermodel.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:provider/provider.dart';

import 'Placeorderbottom_sheet.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var cartFood = Provider.of<CartItems>(context).cartlist;
    var total = Provider.of<CartItems>(context).totalAmount;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                ),
                const Text(
                  " Cart",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                    // color: Color(0xff544646)
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: cartFood.isEmpty
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 260,
                          width: 260,
                          child:
                              SvgPicture.asset(cart_empty)),
                      const Text(
                        "No foods yet",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: cartFood.length,
                    itemBuilder: (context, index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment:
                                  Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                onLongPress: () {},
                                child: Card(
                                  elevation: 0,
                                  shape:
                                      const RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius
                                                  .only(
                                    topLeft:
                                        Radius.circular(85),
                                    topRight:
                                        Radius.circular(10),
                                    bottomLeft:
                                        Radius.circular(85),
                                    bottomRight:
                                        Radius.circular(10),
                                  )),
                                  child: Container(
                                    height: 100,
                                    padding:
                                        const EdgeInsets
                                                .only(
                                            left: 110),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                cartFood[
                                                        index]
                                                    .title,
                                                style:
                                                    const TextStyle(
                                                  fontWeight:
                                                      FontWeight
                                                          .bold,
                                                  fontSize:
                                                      12,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            additem(
                                                context,
                                                cartFood[
                                                    index]),
                                            const Expanded(
                                              child:
                                                  SizedBox(),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Text(
                                                "Ksh ${((int.parse(cartFood[index].price) * cartFood[index].quantity).toString())}",
                                                style:
                                                    const TextStyle(
                                                  color: Color(
                                                      0xff0A9400),
                                                  fontSize:
                                                      12,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              Alignment
                                                  .topCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets
                                                        .only(
                                                    top: 7,
                                                    right:
                                                        7),
                                            child:
                                                Container(
                                                    height:
                                                        30,
                                                    width:
                                                        30,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                            100),
                                                        color: const Color(
                                                            0xffFFDB84)),
                                                    child:
                                                        Center(
                                                      child:
                                                          Text(
                                                        "${cartFood[index].quantity}",
                                                        style:
                                                            const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          cartFood[index]
                                              .image),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                children: [
                                  const Icon(
                                    Icons_foodApp.clock,
                                    size: 14,
                                    color:
                                        Color(0xff707070),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets
                                            .only(left: 5),
                                    child: Text(
                                      cartFood[index]
                                          .timeFood,
                                      style:
                                          const TextStyle(
                                        fontSize: 10,
                                        color: Color(
                                            0xff707070),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
          ),
          cartFood.isEmpty
              ? const SizedBox()
              : Container(
                  height: 50,
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Ksh $total',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1,
                      )
                    ],
                  ),
                ),
          Container(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Row(
              children: [
                Center(
                  child: Text(
                    'Payment Method',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.white10,
                    thickness: 0.1,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 70,
            margin: const EdgeInsets.only(
                left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white10,
                ),
                borderRadius: BorderRadius.circular(7.0)),
            child: ListTile(
              leading: FittedBox(
                child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        'assets/mpesa.png',
                      ),
                    )),
              ),
              title: Text(
                'Mpesa',
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color,
                    fontSize: 12),
              ),
              subtitle: Text(
                '0727800223',
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color,
                    fontSize: 12),
              ),
              trailing: InkWell(
                child: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  Fluttertoast.showToast(
                      msg:
                          "More Payment Options To be Added Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white,
                      textColor: Colors.black);
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(),
          ),
          if (cartFood.isNotEmpty && isLoading)
            // ignore: dead_code
            const SizedBox(
              height: 10,
            ),
          if (cartFood.isEmpty) const SizedBox(),
          if (cartFood.isNotEmpty && isLoading)
            // ignore: dead_code
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 2,
            ),
          if (cartFood.isNotEmpty && isLoading)
            // ignore: dead_code
            const SizedBox(
              height: 30,
            ),
          if (cartFood.isNotEmpty && !isLoading)
            GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = true;
                });

                var ordernumber = 1;
                Provider.of<CartItems>(
                  context,
                  listen: false,
                )
                    .placeorder(
                        OrderModel(
                          ordernumber.toString(),
                          total,
                          cartFood.length,
                          'Matemo',
                          '0727800223',
                          'Mapangala',
                          'false',
                          DateTime.now(),
                        ),
                        context)
                    .whenComplete(() => {
                          if (mounted)
                            {
                              setState(() {
                                isLoading = false;
                              })
                            }
                        });
              },
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
        ],
      ),
    ));
  }
}

Widget additem(BuildContext context, FoodModel food) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        width: 2,
      ),
      GestureDetector(
        onTap: (() {
          var quantity =
              Provider.of<CartItems>(context, listen: false)
                  .itemquantity(food.id);
          if (quantity! > 1) {
            Provider.of<CartItems>(context, listen: false)
                .removeSingleItem(food.id);
          } else {
            Provider.of<CartItems>(context, listen: false)
                .removeItem(food.id);
          }
        }),
        child: Icon(
          Icons.remove,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: () {
          Provider.of<CartItems>(context, listen: false)
              .addItem(food, food.id);
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 70,
          decoration: const BoxDecoration(
            color: Color(0xffFFDB84),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              food.quantity.toString(),
              style: const TextStyle(
                  color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: (() {
          Provider.of<CartItems>(context, listen: false)
              .addItem(food, food.id);
        }),
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    ],
  );
}
