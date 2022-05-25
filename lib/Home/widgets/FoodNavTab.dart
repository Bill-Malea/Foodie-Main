import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Icons_illustrations.dart';
import '../../Providers/FoodsNavbar.dart';
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
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        TabItem(
          text: 'Fries',
          active: selected[0],
          touched: () {
            setState(() {
              Provider.of<FoodNavBar>(context,
                      listen: false)
                  .select(0);
            });
          },
          icon: icon_pizza,
        ),
        const SizedBox(
          width: 20,
        ),
        TabItem(
          text: 'Smokie',
          active: selected[1],
          touched: () {
            setState(() {
              Provider.of<FoodNavBar>(context,
                      listen: false)
                  .select(1);
            });
          },
          icon: icon_juice,
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
          icon: icon_cake,
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
          icon: icon_leanAndMean,
        ),
        const SizedBox(
          width: 20,
        ),
        TabItem(
          text: 'Juice',
          active: selected[3],
          touched: () {
            setState(() {
              Provider.of<FoodNavBar>(context,
                      listen: false)
                  .select(3);
            });
          },
          icon: icon_paleo,
        ),
      ],
    );
  }
}
