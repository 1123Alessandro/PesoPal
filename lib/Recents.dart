import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math';

import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'DatabaseManager.dart';
import 'AddRecord.dart';

Column recents(BuildContext context, List<Map> recs) {
  List<Widget> elems = [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: TextStyle(
            fontFamily: 'Agrandir',
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        TextButton(
          onPressed: () {
            var db = DatabaseManager();
            db.retrieveTxn().then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage(lis: value,))
              );
            });
          },
          child: Text(
            'See All',
            style: TextStyle(
              fontFamily: 'Agrandir',
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  ];

  for (Map record in recs) {
    if (record['type'] == 'Earn') {
      elems.add(Container(
        decoration: BoxDecoration(
          color: Color(0xFFFDFDFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile (
          leading: Icon(
            CupertinoIcons.arrowtriangle_up_fill,
            size: 30.0,
            color: incomeArrowIn,
          ),
          /*title: Text(currItem['name']),
                          subtitle: Text(currItem['date']),
                          trailing: Text('PHP ${currItem['price'].toString()}'),*/
          title: Text(record['name']),
          subtitle: Text(record['date']),
          trailing: Text('PHP ${record['price'].toString()}'),
          hoverColor: Color(0xFF62929E),
        ),
      ));
    }
    else if (record['type'] == 'Expense') {
      elems.add(Container(
        decoration: BoxDecoration(
          color: Color(0xFFFDFDFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile (
          leading: Icon(
            CupertinoIcons.arrowtriangle_down_fill,
            size: 30.0,
            color: expensesArrowIn,
          ),
          /*title: Text(currItem['name']),
                          subtitle: Text(currItem['date']),
                          trailing: Text('PHP ${currItem['price'].toString()}'),*/
          title: Text(record['name']),
          subtitle: Text(record['date']),
          trailing: Text('PHP ${record['price'].toString()}'),
          hoverColor: Color(0xFF62929E),
        ),
      ));
    }
    else {
      elems.add(Container(
        decoration: BoxDecoration(
          color: Color(0xFFFDFDFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile (
          leading: Icon(
            CupertinoIcons.question_circle,
            size: 30.0,
            color: dark2,
          ),
          /*title: Text(currItem['name']),
                          subtitle: Text(currItem['date']),
                          trailing: Text('PHP ${currItem['price'].toString()}'),*/
          title: Text(record['name']),
          subtitle: Text(record['date']),
          trailing: Text('PHP ${record['price'].toString()}'),
          hoverColor: Color(0xFF62929E),
        ),
      ));
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: elems,
  );
}