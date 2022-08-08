import 'package:flutter/material.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:provider/provider.dart';

import 'Icons_illustrations.dart';
import 'Models/foodModel.dart';

mainBottomSheet(
    BuildContext context, List<FoodModel> foodModel, bool isloading) {
  var _address = '';

  var _phoneNumber = '';
  var _preference = '';

  //                       }
  final GlobalKey<FormState> _globalKey =
      GlobalKey<FormState>();

  initiatepayment() {
    final isvalid = _globalKey.currentState!.validate();
    if (isvalid) {
      // Provider.of<CartItems>(context, listen: false)
      //     .processpayment(
      //         userPhone: _phoneNumber,
      //         amount: 1.0,
      //         context: context
              
      //         ).whenComplete(() {});
    }
  }

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color:
                Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 550,
          child: StatefulBuilder(builder:
              (BuildContext context, StateSetter setState) {
            return Form(
              key: _globalKey,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "Checkout",
                        style: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.streetAddress,
                      onChanged: (val) {
                        _address = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address Recommended";
                        }
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff707070),
                      ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 15),
                        border: InputBorder.none,
                        hintText: "Delivery Address",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        _phoneNumber = val;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input valid Phonenumber";
                          // ignore: missing_return
                        }
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff707070),
                      ),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 15),
                          border: InputBorder.none,
                          hintText: "Mpesa Number"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(left: 34),
                        child: const Text(
                          "Payment Method :",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor:
                                  const Color(0xffFFDB84),
                              value: 1,
                              groupValue: 1,
                              onChanged: (val) {},
                            ),
                            Text("Mpesa",
                                style: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      initiatepayment();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 80, left: 80),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(8),
                            color: const Color(0xffFFDB84)),
                        child: const Center(
                          child: Text(
                            "Process Payment",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }),
        );
      });
}
