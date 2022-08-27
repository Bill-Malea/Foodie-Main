// ignore: must_be_immutable
// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:foodie/Screens/LoadingScreen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/FormInput.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../MainPage.dart';
import '../Utilities/Themes.dart';
import 'package:google_sign_in/google_sign_in.dart';
class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  


  signInWithGoogle() async {


    final googleSignIn = GoogleSignIn();
   try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
       
        if (googleSignInAuthentication.accessToken != null &&
            googleSignInAuthentication.idToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final  authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

      
         return authResult.user;
        } else {
          throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token',
          );
        }
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
    } catch (error) {
      return null;
    }
}  








  final _key = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var _start;

  var _isloading = false;
  var _otpcode = '';

  var _verificationId;

  var _phone = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
           
          ),
        ),
      ),
      body: Form(
        key: _key ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                if(!_isloading)
                     const Text(
                        'Enter your phonenumber to get started',
                        style: TextStyle(color: Colors.black),
                      ),
                   
                const SizedBox(
                  height: 15,
                ),
                !_isloading
                    ? FormInputFieldWithIcon(
                      labelText: 'Phonenumber', 
                    onchanged: (val ) { 
                        setState(() {
                      _phone = val!;
                     
                    });
                     }, 
                     validator: (val) {
                   
                     
                     if(val!.isEmpty){
                   return 'Cannot be blank!';
                    }  else if (val.length < 10 ){
                    return   'Please Enter a valid phonenumber';
                     }
                     return null;
                      },)
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCodeNumberBox(_otpcode.isNotEmpty
                              ? _otpcode.substring(0, 1)
                              : ""),
                          buildCodeNumberBox(_otpcode.length > 1
                              ? _otpcode.substring(1, 2)
                              : ""),
                          buildCodeNumberBox(_otpcode.length > 2
                              ? _otpcode.substring(2, 3)
                              : ""),
                          buildCodeNumberBox(_otpcode.length > 3
                              ? _otpcode.substring(3, 4)
                              : ""),
                          buildCodeNumberBox(_otpcode.length > 4
                              ? _otpcode.substring(4, 5)
                              : ""),
                          buildCodeNumberBox(_otpcode.length > 5
                              ? _otpcode.substring(5, 6)
                              : ""),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                _isloading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Didn't recieve phone ? Resend in 0:${_start.toString()} ",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (kDebugMode) {
                                  print("Resend the phone to the user");
                                }
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            if (!_isloading)
              Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: _verifyPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                  ),
                  child:  Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
      
      
              
            if (_isloading)
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: _verify,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Verify',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
               if (_isloading)
            Expanded(
              child: NumericPad(
                onNumberSelected: (value) async {
                  setState(() {
                    
                      if (value != -1) {
                        if (_otpcode.length < 6) {
                          _otpcode = _otpcode + value.toString();
                        }
                      } else {
                        _otpcode = _otpcode.substring(0, _otpcode.length - 1);
                      }
                    
                  });
                },
              ),
            ),
      
      if(!_isloading)
      Container(
        margin: const EdgeInsets.all(10),
        child:Row(children: const [
          Expanded(
        child: Divider(thickness: 1.0,
        color: Colors.black12,),
          ),
          SizedBox(width: 5,),
          Text('Or'),
          SizedBox(width: 5,),
           Expanded(
         child: Divider(thickness: 1.0,
           color: Colors.black12,),
           ),
        ],)
      ),
      const SizedBox(height: 10,),
      if (!_isloading)
            
               Container(
                padding: const EdgeInsets.all(13),
                 child: SignInButton(
                
          
  Buttons.Google,
  text: "Sign up with Google",
  padding: const EdgeInsets.all(5),
  onPressed: () {
      signInWithGoogle() ;
  },
),
               ),
                
            
          ],
        ),
      ),
    );
  }

  _verify() async {
    if (_otpcode.isNotEmpty && _otpcode.length == 6) {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _otpcode);
      var _val =   await _auth.signInWithCredential(credential)
                    .onError((error, stackTrace) {
                  if (kDebugMode) {
                    print('This is error $error');
                  }
                  return errorToast(error.toString());
                });
      var val = _val.user?.uid;
      if (val!.isNotEmpty) {
        setState(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoadingScreen(isorderplacement: false,),
            ),
          );
        });
      }
    }
  }

  _verifyPhoneNumber() async {
     final isValid = _key.currentState!.validate();
    if (isValid) {
       _key.currentState!.save();
       FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _isloading = true;
      });
      await _auth
          .verifyPhoneNumber(
              timeout: const Duration(seconds: 60),
              phoneNumber: '+254${_phone.substring(1, 10)}',
              verificationCompleted: (PhoneAuthCredential credential) async {
                await _auth.signInWithCredential(credential)
                    .onError((error, stackTrace) {
                  if (kDebugMode) {
                    print('This is error $error');
                  }
                  return errorToast(error.toString());
                });

                setState(() {
                  _otpcode = credential.smsCode!;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MainPage(),
                    ),
                  );
                });
              },
              verificationFailed: (FirebaseAuthException e) {
                setState(() {
                  _otpcode = '';
                  setState(() {
                    _isloading = false;
                  });
                });
              },
              codeSent: (verificationId, resendToken) async {
                setState(() {
                  _verificationId = verificationId;
                  if (kDebugMode) {
                    print(verificationId);
                  }
                });
              },
              codeAutoRetrievalTimeout: (String timeout) {
                setState(() {
                  _isloading = false;
                });
              })
          .onError((error, stackTrace) {
        return errorToast(error.toString());
      });
    } else {
      errorToast('Enter a valid phonenumber ');
    }
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: SizedBox(
        width: 25,
        height: 25,
        child: Container(
          decoration:  BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumericPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  const NumericPad({Key? key, required this.onNumberSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(1),
              buildNumber(2),
              buildNumber(3),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(4),
              buildNumber(5),
              buildNumber(6),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNumber(7),
              buildNumber(8),
              buildNumber(9),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildEmptySpace(),
              buildNumber(0),
              buildBackspace(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNumber(int number) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onNumberSelected(number);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return Expanded(
      child: InkWell(
        onTap: () {
          onNumberSelected(-1);
        },
        child: const Padding(
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: const Icon(
              Icons.close,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return const Expanded(
      child: SizedBox(),
    );
  }
}
