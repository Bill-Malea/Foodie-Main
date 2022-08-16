import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/Icons_illustrations.dart';
import 'package:foodie/Models/foodModel.dart';
import 'package:foodie/Providers/Cartprovider.dart';
import 'package:provider/provider.dart';
import 'FormInput.dart';
import 'Models/Ordermodel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


final _key = GlobalKey<FormState>();


















var user = FirebaseAuth.instance;
  bool isLoading = false;
  String _preference = '';
   String _address = '';
   String _phonenumber = '';
  @override
  Widget build(BuildContext context) {
    var cartFood = Provider.of<CartItems>(context).cartlist;
    var total = Provider.of<CartItems>(context).totalAmount;


_placeorder() async{

  final isValid = _key.currentState!.validate();
      if (isValid) {
        _key.currentState!.save();
       
 setState(() {
                      isLoading = true;
                    });
        final random = Random();
                    var ordernumber = random.nextIntOfDigits(9);
                await   Provider.of<CartItems>(
                      context,
                      listen: false,
                    ).placeorder(context: context, order: OrderModel(
                             
                               address: '', 
                               dateTime: DateTime.now().toIso8601String(), 
                               foods: cartFood, 
                               nameCustomer: user.currentUser!.displayName, 
                               orderNumber: ordernumber.toString(), 
                               orderStatus: '', 
                               phoneNumber: user.currentUser!.phoneNumber ?? _phonenumber  , 
                               totalPrice: total.toString(), 
                               prefences: _preference,
                            ),
                         )
                        .whenComplete(() => {
                              if (mounted)
                                {
                                  setState(() {
                                    isLoading = false;
                                    _preference= '';
                                  })
                                }
                            });
                 
        




      }



  }

    return Scaffold(
      appBar: AppBar(

        leading:  Container(
                      margin: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                        ),
                      ),
                    ),
                    centerTitle: true,
                  title: const Text(
                      " Cart",
                      style: TextStyle(
                        
                        fontWeight: FontWeight.bold,
        
                        // color: Color(0xff544646)
                      ),
                    ),
        ),
        body:  Form(
          key:_key ,
          child: SingleChildScrollView(
                child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
               
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: cartFood.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 200,
                               
                                child: SvgPicture.asset(cart_empty)),
                          ],
                        )
                      : ListView.builder(
                          itemCount: cartFood.length,
                          itemBuilder: (context, index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {},
                                      
                                      child: Card(
                                        elevation: 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(85),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(85),
                                          bottomRight: Radius.circular(10),
                                        )),
                                        child: Container(
                                          height: 100,
                                          padding: const EdgeInsets.only(left: 110),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      cartFood[index].title,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  additem(context, cartFood[index]),
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      "Ksh ${((int.parse(cartFood[index].price) * cartFood[index].quantity).toString())}",
                                                      style: const TextStyle(
                                                        color: Color(0xff0A9400),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 7, right: 7),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  100),
                                                          color: const Color(
                                                              0xffFFDB84)),
                                                      child: Center(
                                                        child: Text(
                                                          "${cartFood[index].quantity}",
                                                          style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(cartFood[index].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 20,
                                    bottom: 10,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons_foodApp.clock,
                                          size: 14,
                                          color: Color(0xff707070),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                            cartFood[index].timeFood,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff707070),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                ),
                cartFood.isEmpty
                    ? const SizedBox()
                    : Container(
                        height: 50,
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Ksh $total',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
          
          
          if (cartFood.isNotEmpty && !isLoading)FormInputFieldWithIcon(labelText: 'Preference e.g Crispy, add salad',
          
           onchanged: (val ) {  setState(() {
                    _preference = val!;
                  }); }, validator: (val) {
                    return null;
                   
                    
                     // return val!.length < 5 ? 'Too short' : null ;
                       
                       },),
               
                 if (cartFood.isNotEmpty && !isLoading)  InkWell(
                    onTap:_placeorder,
                   
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFDB84),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          ' Proceed to Checkout',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),),
        
                         if ( cartFood.isNotEmpty && isLoading)
                         
                             CircularProgressIndicator(color: Theme.of(context).iconTheme.color,
          strokeWidth: 1.0),
                          
                         
          const SizedBox(height: 110,),
                
              ],
            ),
                ),
              ),
        ),
        );
  }

 
}












Widget additem(BuildContext context, FoodModel food) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        width: 2,
      ),
      GestureDetector(
        onTap: (() {
          var quantity = Provider.of<CartItems>(context, listen: false)
              .itemquantity(food.id);
          if (quantity! > 1) {
            Provider.of<CartItems>(context, listen: false)
                .removeSingleItem(food.id);
          } else {
            Provider.of<CartItems>(context, listen: false).removeItem(food.id);
          }
        }),
        child: Icon(
          Icons.remove,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: () {
          Provider.of<CartItems>(context, listen: false).addItem(food, food.id);
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 70,
          decoration: const BoxDecoration(
            color: Color(0xffFFDB84),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              food.quantity.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: (() {
          Provider.of<CartItems>(context, listen: false).addItem(food, food.id);
        }),
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),



      
    ],
  );
  
}

extension RandomOfDigits on Random {
  /// Generates a non-negative random integer with a specified number of digits.
  ///
  /// Supports [digitCount] values between 1 and 9 inclusive.
  num nextIntOfDigits(int digitCount) {
    assert(1 <= digitCount && digitCount <= 9);
    num min = digitCount == 1 ? 0 : pow(10, digitCount - 1);
    num max = pow(10, digitCount);
    return min + nextInt(int.parse((max - min).toString()));
  }
}





























