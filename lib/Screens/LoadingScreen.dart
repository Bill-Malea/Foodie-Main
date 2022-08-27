
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodie/Providers/Foodsprovider.dart';
import 'package:provider/provider.dart';

import '../MainPage.dart';
import '../Providers/AddressesProvider.dart';
import '../Providers/Ordersprovider.dart';

class LoadingScreen extends StatefulWidget{
  final  bool isorderplacement;
  const LoadingScreen({Key? key, required this.isorderplacement}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
@override
  void initState() {
    super.initState();
  
    Future.delayed(Duration.zero,() {
        
        Provider.of< OrdersProvider>(context,listen: false).loadorders();
         Provider.of< AddressesProvider>(context,listen: false).fetchaddresses();
    });
  }

  
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor ,
body:


widget.isorderplacement ?   Center(
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
                                        'assets/success.png',
                                        width: 60,
                                        height: 60,
                                        fit:BoxFit.fill  

                                      ),
      const SizedBox(height: 20,),
      const Text('Order Placed Succesfully',
      style: TextStyle(fontSize: 16,
     // fontWeight: FontWeight.bold,
      
      ),),
    ],
  )
)  :

FutureBuilder(
          future:   Provider.of<FoodsProvider>(context,listen: false).loadfoods(),
          builder: ((context, snapshot) {
          if(snapshot.hasData){
       SchedulerBinding.instance?.addPostFrameCallback((_) {


Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainPage(),
            ),
          );
});



          }else if(snapshot.hasError){
           
const Center(
  child:   Text('An Error Occured'),
);

          }


 return 
 Center(
  child:   CircularProgressIndicator(strokeWidth: 1,
  color: Theme.of(context).iconTheme.color,)
);


          }
)));
  }}




