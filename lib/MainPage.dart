import 'package:flutter/material.dart';
import 'package:foodie/Home.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {









  final int _selectedIndex = 0;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // DBFireStore dbFireStore = DBFireStore();
  // final _auth = FBAuth();
  // User _loggedUser;

  // getCurrentUser() async{

  //   _loggedUser = await _auth.getUser();
  // }

  // @override
  // // ignore: must_call_super
  // void initState() {
  //   getCurrentUser();
  //   configureCallBack();
  //   getDeviceToken();
  // }

  // void getDeviceToken() async{

  //   String deviceToken =  await _firebaseMessaging.getToken();
  //   print("deviceToken : $deviceToken");
  // }

  // void configureCallBack() {

  //   _firebaseMessaging.configure(

  //       onMessage: (message) async{

  //         print("onMessage : $message");
  //       },
  //     onResume: (message) async{

  //         print("onResume : $message");
  //     },
  //     onLaunch: (message) async{

  //       Navigator.pushNamed(context, MainPage.id);
  //     },
  //   );
  // }

  final List<Widget> _pages = <Widget>[
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
        ),
      ],
    ));
  }
}
