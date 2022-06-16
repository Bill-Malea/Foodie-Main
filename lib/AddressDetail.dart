import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {


    return Column(

      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.3,
          
        )
      ],
    );
  }
}
