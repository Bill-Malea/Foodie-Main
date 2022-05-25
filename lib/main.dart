import 'package:flutter/material.dart';
import 'package:foodie/Providers/Themeprovider.dart';

import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'MainPage.dart';
import 'Providers/Cartprovider.dart';
import 'Providers/FoodsNavbar.dart';
import 'Providers/Foodsprovider.dart';

void main() async {
  await GetStorage.init();

  MpesaFlutterPlugin.setConsumerKey(
      'OBjOaunSAchhYKM6mB7helT36Slg1grw');
  MpesaFlutterPlugin.setConsumerSecret('WCcbntBI1Di9txIa');
  var preferences = GetStorage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => FoodsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FoodNavBar(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartItems(),
      ),
    ],
    child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(
            isDarkMode: preferences.read("isDarkTheme")),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themProvider.getTheme,
            home: const MainPage());
      },
    );
  }
}
