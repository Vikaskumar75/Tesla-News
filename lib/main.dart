import 'package:flutter/material.dart';
import 'package:TeslaNews/pages/home.dart';
void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[400],
      ),
      home: Home(),
    );
  }
}
