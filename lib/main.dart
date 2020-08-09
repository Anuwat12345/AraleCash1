import 'package:anuwatmarket/wiget/authen.dart';
import 'package:flutter/material.dart';

main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, //close debug banner
      home: Authen(),
      title: 'Arale Cash', //Add 'title' to app
    ); //Area for design...Appear on screen
  }
}