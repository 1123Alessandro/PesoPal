import 'package:flutter/material.dart';
import 'home_layout.dart';
import 'analytics.dart';
import 'transaction_history.dart';
import 'add_record.dart';

void main() => runApp(AddPage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFDCDCDC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFDFDFF),
        ),
        scaffoldBackgroundColor: Color(0xFFFDFDFF),
      ),
      // TODO: change method name per webpage view
      home: AddPage(),
    );
  }
}
