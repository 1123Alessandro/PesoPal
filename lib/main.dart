import 'package:flutter/material.dart';
import 'Home.dart';
import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'AddRecord.dart';
import 'Entrance.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFDCDCDC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFDFDFF),
        ),
        scaffoldBackgroundColor: Color(0xFFFDFDFF),
      ),
      // TODO: change method name per webpage view
      home: WelcomePage(),
    );
  }
}
