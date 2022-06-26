import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? get getTheme => _selectTheme;
  ThemeData? _selectTheme;

  ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.black,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        button: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        headline1: const TextStyle(
          color: Color(0xff544646),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        bodyText1: const TextStyle(
          color: Color(0xff544646),
          fontSize: 12,
        ),
        bodyText2:
            const TextStyle(color: Color(0xff544646)),
          caption: const TextStyle(
          color: Colors.grey,
          fontSize: 11.0,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 20,
      ),
      
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xffFFFAEE),
      ),
      dialogBackgroundColor:
          const Color.fromARGB(220, 255, 243, 238),
      dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(
        color: Color(0xff544646),
      )),
      scaffoldBackgroundColor:  Colors.white,
      //FFFAEE),
      appBarTheme: const AppBarTheme(
          iconTheme:
              IconThemeData(size: 20, color: Colors.black),
          color: Color(0xfff7ab0a),
          titleTextStyle:
              TextStyle(fontSize: 15, color: Colors.black)),
      cardTheme: const CardTheme(
        color: Color.fromARGB(125, 255, 240, 196),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xff212226),
        primary: const Color(0xfff7ab0a),
      ),
      
      
      );

  ThemeData dark = ThemeData.dark().copyWith(
    iconTheme: const IconThemeData(
      color: Color(0xffFFDB84),
      size: 20,
    ),
    primaryColor: const Color(0xfff7ab0a),
    dialogBackgroundColor: const Color(0xff212226),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(color: Color(0xffffb800)),
    ),
    scaffoldBackgroundColor: const Color(0xff121417),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
            size: 20, color: Color(0xffffb800)),
        color: Color(0xff121417),
        titleTextStyle: TextStyle(
            fontSize: 15, color: Color(0xffFFFAEE))),
    cardTheme: const CardTheme(color: Color(0xff212226)),
    textTheme: const TextTheme(
      button: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      bodyText1: TextStyle(
        color: Color(0xffFFFAEE),
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Color(0xffffb800),
        fontSize: 12,
      ),
      headline1: TextStyle(
        color: Color(0xffffb800),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xff212226),
        primary:const Color(0xff121417) ),
  );

  ThemeProvider({required bool isDarkMode}) {
    try {
      if (!isDarkMode) {
        _selectTheme = light;
      } else {
        _selectTheme = isDarkMode ? dark : light;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> swapTheme() async {
    var preferences = GetStorage();
    if (_selectTheme == dark) {
      _selectTheme = light;
      preferences.write("isDarkTheme", false);
    } else {
      _selectTheme = dark;
      preferences.write("isDarkTheme", true);
    }
    notifyListeners();
  }
}
