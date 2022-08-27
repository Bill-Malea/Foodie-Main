
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Screens/ProcessingPayment.dart';
import 'package:provider/provider.dart';
import '../FormInput.dart';
import '../Models/Ordermodel.dart';
import '../Providers/Cartprovider.dart';

class Payment extends StatefulWidget {
  final OrderModel order;
   const Payment({ Key? key, required this.order }) : super(key: key);
 
   @override
   State<Payment> createState() => _PaymentState();
 }
 
 class _PaymentState extends State<Payment> {
final _key = GlobalKey<FormState>();
  bool  _isLoading = false;
  bool  _processingpayment = false;
var _phonenumber;
var user = FirebaseAuth.instance;


   @override
   Widget build(BuildContext context) {

_placeorder() async{

final isValid = _key.currentState!.validate();
      if (isValid) {
        _key.currentState!.save();
 setState(() {
                      _isLoading= true;
                      
                    });

                await   Provider.of<CartItems>(
                      context,
                      listen: false,
                    ).processpayment(context: context,  userPhone: _phonenumber ?? '0${user.currentUser?.phoneNumber?.substring(4,13)}',order: widget.order )
                        .whenComplete(() => {
                              if (mounted)
                                {
                                  setState(() {
                                    _isLoading = false;
                                   
                                  })
                                }
                            }).then((val) async{   

   if(val ==  '0' ) {
 setState(() {
  _processingpayment = true;
});
 Future.delayed(const Duration(seconds: 10), () {
 
Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => FetchPayment(order: widget.order,),
            ),
          );
          if(mounted){
            
setState(() {
  _processingpayment = false;
});
          }
          
          
          
           });

}    });
                 
        
         }



  }





     return Scaffold
     (
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
        title: const Text( 'Payment') ,centerTitle: true,),
       body: _processingpayment ?   
       
       Center(
  child:   Column(
  mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(strokeWidth: 1,
      color: Theme.of(context).iconTheme.color,),
      const SizedBox(height: 30,),
      const Text('Enter Mpesa Pin To Complete payment')
    ],
  )
)
       
       : Container(

padding: const EdgeInsets.all(15),

         child: Form(
          key: _key,
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
          Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      child: Row(
                        children: [
                          Center(
                            child: Text(
                              'Payment Method',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.white10,
                              thickness: 0.1,
                            ),
                          )
                        ],
                      ),
                    ),
              Container(
                      height: 70,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white10,
                          ),
                          borderRadius: BorderRadius.circular(7.0)),
                      child: ListTile(
                        leading: FittedBox(
                          child: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: SizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                  'assets/mpesa.png',
                                ),
                              )),
                        ),
                       
                        
         
         
                        trailing: InkWell(
                          child: Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 20,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "More Payment Options To be Added Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Theme.of(context).cardTheme.color,
                                textColor: Colors.black);
                          },
                        ),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Divider(),
              ),
             FormInputField( 
              onchanged: (val ) { 
                 setState(() {
                        _phonenumber = val!;
                      });
              }, 
              validator: (val ) { 
                    return val!.length < 10 ? 'Enter a valid phonenumber' : null ;
               }, 
              
              
               labeltext:'Enter Mpesa Number',),
             const SizedBox(height: 20,),
              if (_isLoading)
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2,
                ),
              
                if (!_isLoading)  GestureDetector(
                  onTap: _placeorder,
                  
             
         
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
                        'Complete Your Order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
         
         
         
         
            ],
           ),
         ),
       ),
     );
   }
 }


















 
class FormInputField extends StatelessWidget {
  

  final String? labeltext;
  const FormInputField({
    Key? key,
  required this.labeltext,
    
    required this.validator,
   
    required this.onchanged,
  }) : super(key: key);

  final String? Function(String?) validator;

  final void Function(String?) onchanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(

        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 0.0,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 0.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 0.0,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
          
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
       
        keyboardType: TextInputType.number,
      
        validator: validator,
        onChanged: onchanged,
      ),
    );
  }
}