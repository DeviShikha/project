import 'package:flutter/material.dart';
import 'package:letsenklineproject/firstScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApiIntegration(),
    );
  }
}