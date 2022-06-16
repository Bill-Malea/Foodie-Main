// ignore: must_be_immutable
// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../MainPage.dart';
import '../Utilities/Themes.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              !_isloading
                  ? const Text(
                      'Enter your phonenumber to get started',
                      style: TextStyle(color: Colors.white),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Enter phone sent to +254" + _phone.substring(1, 10),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              !_isloading
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            _phone.isNotEmpty ? _phone.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            _phone.length > 1 ? _phone.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            _phone.length > 2 ? _phone.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            _phone.length > 3 ? _phone.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            _phone.length > 4 ? _phone.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            _phone.length > 5 ? _phone.substring(5, 6) : ""),
                        buildCodeNumberBox(
                            _phone.length > 6 ? _phone.substring(6, 7) : ""),
                        buildCodeNumberBox(
                            _phone.length > 7 ? _phone.substring(7, 8) : ""),
                        buildCodeNumberBox(
                            _phone.length > 8 ? _phone.substring(8, 9) : ""),
                        buildCodeNumberBox(
                            _phone.length > 9 ? _phone.substring(9, 10) : ""),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(_otpcode.length > 0
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
              SizedBox(
                height: _isloading ? 10 : 40,
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
                  primary: Colors.red,
                ),
                child: const Text(
                  'Verify phone number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          if (_isloading)
            Container(
              margin: const EdgeInsets.all(15),
              child: ElevatedButton(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                onPressed: _verify,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
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
          Expanded(
            child: NumericPad(
              onNumberSelected: (value) async {
                setState(() {
                  if (!_isloading) {
                    if (value != -1) {
                      if (_phone.length < 10) {
                        _phone = _phone + value.toString();
                      }
                    } else {
                      _phone = _phone.substring(0, _phone.length - 1);
                    }
                  } else {
                    if (value != -1) {
                      if (_otpcode.length < 6) {
                        _otpcode = _otpcode + value.toString();
                      }
                    } else {
                      _otpcode = _otpcode.substring(0, _otpcode.length - 1);
                    }
                  }
                });
              },
            ),
          ),
        ],
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
              builder: (BuildContext context) => const MainPage(),
            ),
          );
        });
      }
    }
  }

  _verifyPhoneNumber() async {
    if (_phone.length == 10) {
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
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: <BoxShadow>[
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
