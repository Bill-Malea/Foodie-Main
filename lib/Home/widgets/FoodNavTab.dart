import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/FoodsNavbar.dart';
import '../../Utilities/icon_custom_icons.dart';
import 'TabItem.dart';

class NavigationTabs extends StatefulWidget {
  const NavigationTabs({
    Key? key,
  }) : super(key: key);
  @override
  _NavigationTabsState createState() =>
      _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  @override
  Widget build(BuildContext context) {
    final selected =
        Provider.of<FoodNavBar>(context).selected;
    return Container(
   
     decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20) ),
    color: Color(0xffffb800),
  ),
  padding: const EdgeInsets.only(left: 15,right: 15),
      height: 75,
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          TabItem(
            text: 'All',
            active: selected[0],
            touched: () {
              setState(() {
                Provider.of<FoodNavBar>(context,
                        listen: false)
                    .select(0);
              });
            },
            icon:Icon_custom.allfoods,
          ),
          const SizedBox(
            width: 20,
          ),
          TabItem(
            text: 'Fries',
            active: selected[1],
            touched: () {
              setState(() {
                Provider.of<FoodNavBar>(context,
                        listen: false)
                    .select(1);
              });
            },
            icon: Icon_custom.fries,
          ),
          const SizedBox(
            width: 20,
          ),
          TabItem(
            text: 'Chicken',
            active: selected[2],
            touched: () {
              setState(() {
                Provider.of<FoodNavBar>(context,
                        listen: false)
                    .select(2);
              });
            },
            icon: Icon_custom.chicken,
          ),
          const SizedBox(
            width: 20,
          ),
          TabItem(
            text: 'Ice Cream',
            active: selected[3],
            touched: () {
              setState(() {
                Provider.of<FoodNavBar>(context,
                        listen: false)
                    .select(3);
              });
            },
            icon: Icon_custom.icecream,
          ),
          const SizedBox(
            width: 20,
          ),
          TabItem(
            text: 'Juice',
            active: selected[4],
            touched: () {
              setState(() {
                Provider.of<FoodNavBar>(context,
                        listen: false)
                    .select(4);
              });
            },
            icon: Icon_custom.juice,
          ),
          
        ],
      ),
    );
  }
}
