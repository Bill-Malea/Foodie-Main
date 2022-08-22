import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Icons_illustrations.dart';
import 'package:foodie/Providers/Themeprovider.dart';
import 'package:foodie/Utilities/Themes.dart';
import 'package:foodie/Wishlist.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Orderpage.dart';
import 'Screens/Addresses.dart';

class Drawerwidg extends StatefulWidget {
  const Drawerwidg({Key? key}) : super(key: key);

  @override
  _DrawerwidgState createState() => _DrawerwidgState();
}

class _DrawerwidgState extends State<Drawerwidg> {
  bool isLoading = false;

  bool themeSwitch = false;
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    itemsdrawer(IconData icon, String name, dynamic fn) {
      return InkWell(
        onTap: fn,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15, left: 5),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 140,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  themeSwitch = !themeSwitch;
                  themeProvider.swapTheme();
                });
              },
              child: themeSwitch
                  ? const Icon(
                      Icons_foodApp.white_mode,
                    )
                  : const Icon(
                      Icons_foodApp.dark_mode,
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: Colors.black12,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'My Account',
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).textTheme.bodyText1?.color),
            ),
            const SizedBox(
              height: 25,
            ),
            itemsdrawer(Icons.card_travel, 'Orders', orders),
            itemsdrawer(Icons.favorite_outline_sharp, 'Wishlist', wishlist),
            itemsdrawer(Icons.place, 'Address', addresses),
            itemsdrawer(Icons.people, 'Invite', () {}),
            itemsdrawer(Icons.share, 'Share', _share),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black12,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Support',
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).textTheme.bodyText1?.color),
            ),
            const SizedBox(
              height: 25,
            ),
            itemsdrawer(Icons.call, 'Call', makecall),
            itemsdrawer(Icons.email, 'Email', sendemail),
            itemsdrawer(Icons.whatsapp, 'Whatsapp', launchwatsapp),
            itemsdrawer(Icons.ac_unit, 'FAQ', () {}),
            const Divider(
              color: Colors.black12,
              thickness: 1.0,
            ),
            itemsdrawer(Icons.logout, 'Log out', () {
              GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
            }),
          ],
        ),
      ),
    );
  }

  makecall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0727800223',
    );
    await launchUrl(launchUri);
  }

  orders() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const OrderPage()));
  }

  wishlist() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const Wishlist()));
  }
  
  addresses() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const Addresses()));
  }

  sendemail() {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'biltriq2@gmail.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'Foodie Customer Equiry'}),
    );

    launchUrl(emailUri);
  }

   _share() {
    Share.share('check out my website https://example.com');
  }






}























launchwatsapp() async {
  String text = 'Foodie Customer Equiry';
  var whatsappURlAndroid = "whatsapp://send?phone=+254727800223&text=$text";
  var whatsappURLIos = "https://wa.me/+254727800223?text=${Uri.tryParse(text)}";
  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      errorToast('Whatsapp Not Installed');
    }
  } else {
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      errorToast('Whatsapp Not Installed');
    }
  }
}
