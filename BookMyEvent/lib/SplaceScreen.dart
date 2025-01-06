import 'dart:async';

import 'package:apiselfproject/Home.dart';
import 'package:flutter/material.dart';

class MySplaceScreen extends StatefulWidget {
  const MySplaceScreen({super.key});

  @override
  State<MySplaceScreen> createState() => _MySplaceScreenState();
}

class _MySplaceScreenState extends State<MySplaceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomeScreen(),));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,

    );
  }
}
