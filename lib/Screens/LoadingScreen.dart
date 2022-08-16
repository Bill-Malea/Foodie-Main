

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget{
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Color(0xfff7ab0a),
body: Center(
  child:   CircularProgressIndicator(strokeWidth: 1,
  color: Colors.black,)
),

    );
  }}
