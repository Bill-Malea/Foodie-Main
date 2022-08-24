import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodie/AddressDetail.dart';
import 'package:foodie/CartPage.dart';
import 'package:foodie/Home.dart';
import 'package:foodie/Orderpage.dart';
import 'package:foodie/Wishlist.dart';
import 'package:provider/provider.dart';
import '../../Icons_illustrations.dart';
import '../../Providers/Cartprovider.dart';
import '../../Providers/Utilityprovider.dart';
import '../../Utilities/icon_custom_icons.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({
    Key? key,
  }) : super(key: key);
  @override
  _BottomnavState createState() =>
      _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  @override
  Widget build(BuildContext context) {

    var _cartitems =
        Provider.of<CartItems>(context, listen: false)
            .itemsCount;
    var cartFood = Provider.of<CartItems>(context);
    return Container(
   
     decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft   :Radius.circular(10),topRight:Radius.circular(10) ),
    color: Color(0xfff7ab0a),
  ),
  padding: const EdgeInsets.only(left: 15,right: 15),
      height: 65,
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          TabItemBottomNav(
            text: 'Home',
          
            touched: () {
       //////
            },
           widgt: const Icon(Icons.home_outlined,
            size: 14,
            color: Colors.black,

          ),
          ),
          const SizedBox(
            width: 20,
          ),
          TabItemBottomNav(
            text: 'Orders',
           
            touched: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const OrderPage()));
            },
           widgt: const Icon(Icons.favorite_outline_sharp,
            size: 14,
            color: Colors.black,

          ),
          ),
          const SizedBox(
            width: 20,
          ),
          TabItemBottomNav(
            text: 'Cart',
            
            touched: () {
            
             Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const CartPage()));
            },






            widgt:   _cartitems == 0
              ? const Icon(
                Icons_foodApp.cart,
                size: 17,
              )
              : Badge(
                animationType: BadgeAnimationType.scale,
                animationDuration:
                    const Duration(milliseconds: 400),
                badgeColor: const Color(0xffff124d),
                elevation: 0,
                position: BadgePosition.bottomEnd (
                    bottom: 8, end: -8),
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
          TabItemBottomNav(
            text: 'Wishlist',
         
            touched: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const Wishlist()));
            },
            widgt: const Icon(Icons.favorite_outline_sharp,
            size: 14,
            color: Colors.black,

          ),
          ),
          const SizedBox(
            width: 20,
          ),
          TabItemBottomNav(
            text: 'Address',
            
            touched: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const AddressPage()));
            },
            widgt: const Icon(Icons.place,
            size: 14,
            color: Colors.black,

          ),
          )
        ],
      ),
    );
  }
}




class TabItemBottomNav extends StatefulWidget {
  final Function touched;
  final Widget widgt;


  final String text;
  const TabItemBottomNav({
    Key? key,
    required this.touched,
    required this.text,
    required this.widgt,
  }) : super(key: key);
  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItemBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          widget.touched();
        },
        child: SingleChildScrollView(
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
              
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [


                    widget.widgt,
                    
                     const SizedBox(
                      height: 5,
                    ),
                   Text(
                      widget.text,
                      style:const TextStyle(fontSize: 10,
                     
                     color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
