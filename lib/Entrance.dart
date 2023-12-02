import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pesopal/Home.dart';
import 'constants.dart';

import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'DatabaseManager.dart';

class Entrance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(onPressed: () {
            DatabaseManager().dashBoard().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(dash: value,))
              );
            });
          },
          child: Text('Start'))
        ],
      ),
    );
  }
}