import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/CartPage.dart';
import 'package:foodie/Drawer.dart';
import 'package:foodie/Providers/Utilityprovider.dart';
import 'package:foodie/Providers/Foodsprovider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'Home/widgets/FoodNavTab.dart';
import 'Home/widgets/FoodsGrid.dart';
import 'Home/widgets/TabItem.dart';
import 'Icons_illustrations.dart';
import 'Providers/Cartprovider.dart';
import 'Providers/Themeprovider.dart';
import 'Utilities/icon_custom_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final selected =
        Provider.of<Utilityprovider>(context).selected;
        
    final selectedindex =
        Provider.of<Utilityprovider>(context).selectetab;
    var _allfood =
        Provider.of<FoodsProvider>(context).allfoods;
    var _icecream =
        Provider.of<FoodsProvider>(context).iceCream;
        var _chicken =
        Provider.of<FoodsProvider>(context).chicken;
         var _fries =
        Provider.of<FoodsProvider>(context).fries;
        var _drinks =
        Provider.of<FoodsProvider>(context).juice;

    var cartFood = Provider.of<CartItems>(context);
    List<Widget> tabWidgets = <Widget>[
      FoodGrid(
        foodModel: _allfood,
      ),
      FoodGrid(
        foodModel: _fries,
      ),
      FoodGrid(
        foodModel: _chicken,
      ),
    FoodGrid(
        foodModel: _icecream,
      ),
     FoodGrid(
        foodModel: _drinks,
      ),
    ];
    
    var _cartitems =
        Provider.of<CartItems>(context, listen: false)
            .itemsCount;
    var _selected =
        Provider.of<Utilityprovider>(context).selectetab;
    return Scaffold(
      appBar: AppBar(
        actions: [
          _cartitems == 0
              ? GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder:
                                (BuildContext context) =>
                                    const CartPage()));
                  }),
                  child: const Icon(
                    Icons_foodApp.cart,
                    size: 17,
                  ),
                )
              : GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder:
                                (BuildContext context) =>
                                    const CartPage()));
                  }),
                  child: Badge(
                    animationType: BadgeAnimationType.scale,
                    animationDuration:
                        const Duration(milliseconds: 400),
                    badgeColor: const Color(0xffff124d),
                    elevation: 0,
                    position: BadgePosition.topEnd(
                        top: 8, end: -8),
                    child: const Icon(
                      Icons_foodApp.cart,
                      size: 17,
                    ),
                    badgeContent: Text(
                      cartFood.itemsCount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          const SizedBox(
            width: 20,
          ),
         
          const SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Foodie",
        ),
        elevation: 0,
      ),
       drawer: const Drawerwidg(),
       bottomNavigationBar: const NavigationTabs (),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
         
         // const NavigationTabs(),
          tabWidgets.elementAt(_selected),
        ],
      ),
    );
  }
}
















