import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:foodie/Providers/AddressesProvider.dart';
import 'package:foodie/Providers/Themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodie/Screens/LoadingScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'AuthScreen/Phoneauth.dart';
import 'MainPage.dart';
import 'Providers/Cartprovider.dart';
import 'Providers/Utilityprovider.dart';
import 'Providers/Foodsprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Providers/Ordersprovider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
void main() async {

     WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  
await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  await GetStorage.init();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
var preferences = GetStorage();
bool theme = preferences.read("isDarkTheme")?? false ;
  MpesaFlutterPlugin.setConsumerKey(
      'OBjOaunSAchhYKM6mB7helT36Slg1grw');
  MpesaFlutterPlugin.setConsumerSecret('WCcbntBI1Di9txIa');
  
  runApp(MultiProvider(
    key: ObjectKey(DateTime.now().toString()),
    providers: [
      ChangeNotifierProvider(
        create: (context) => FoodsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Utilityprovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartItems(),
      ),
ChangeNotifierProvider(
        create: (context) => OrdersProvider(),
        
      ),

ChangeNotifierProvider(
        create: (context) => AddressesProvider(),
      ),
    ],
    child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(
            isDarkMode: theme
            
            
            ),
        child: const MyApp()),
  ));
  FlutterNativeSplash.remove();
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 
  @override
  Widget build(BuildContext context) {
    
 
    return Consumer<ThemeProvider>(
      builder: (context, themProvider, child) {
        return 
        MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themProvider.getTheme,
            home:  StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges() ,
              builder: (BuildContext context, snap) {
             
                 if(snap.hasData){
                  return const LoadingScreen(isorderplacement: false,);
                }
                return const VerifyPhone();
              }),
        );
      },
    );
  }
}
