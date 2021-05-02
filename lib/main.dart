import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsApp.debugAllowBannerOverride=false;

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black),
      home: PriceScreen(),
    );
  }
}
