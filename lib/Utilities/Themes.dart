

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

errorToast(String msg){
  return 
 Fluttertoast.showToast(
        msg:
          msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );

}