import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peso_pal/constants.dart';
import 'dart:math';

import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'DatabaseManager.dart';
import 'AddRecord.dart';

enum NavBar {Home, Analytics}
const activeCardColor = Color(0xFFC6C5B9);

class HomePage extends StatefulWidget {
  List<Map> dash;
  HomePage({required this.dash});

  @override
  _HomeLayoutState createState() => _HomeLayoutState(dash: this.dash);
}

class _HomeLayoutState extends State<HomePage> {
  List<Map> dash;
  NavBar selectedNav = NavBar.Home;
  double totalIncome = 500;
  double totalExpenses = 45;
  //double totalBalance = 0;

  _HomeLayoutState({required this.dash}) {
    totalIncome = (dash[0]['type'] == 'Earn') ? dash[0]['total'] : dash[1]['total'];
    totalExpenses = (dash[0]['type'] == 'Expense') ? dash[0]['total'] : dash[1]['total'];
    print('LOOK AT THIS DASHBOARD');
    print(dash);
    print(totalIncome);
    print(totalExpenses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 10.0,
            height: 50.0,
          ),
          Expanded(
            child: ReusableCard(
              color: activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontFamily: 'Agrandir',
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'PHP',
                        style: TextStyle(
                          fontFamily: 'Agrandir',
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        '${((totalIncome - totalExpenses).toStringAsFixed(2))}',
                        style: TextStyle(
                          fontFamily: 'Agrandir',
                          fontWeight: FontWeight.w900,
                          fontSize: 45.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFDFDFF),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.arrowtriangle_up_fill,
                                      size: 25.0,
                                      color: incomeArrowIn,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                      height: 20.0,
                                    ),
                                    Text(
                                      '${totalIncome.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ),
                      SizedBox(
                        width: 30.0,
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFDFDFF),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.arrowtriangle_down_fill,
                                    size: 25.0,
                                    color: expensesArrowIn,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                    height: 20.0,
                                  ),
                                  Text(
                                    '${totalExpenses.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: activeCardColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                  Container(
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
                      title: Text('Item 1'),
                      subtitle: Text('Item description'),
                      trailing: Icon(Icons.more_vert),
                      hoverColor: Color(0xFF62929E),
                    ),
                  ),
                  Container(
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
                      title: Text('Item 1'),
                      subtitle: Text('Item description'),
                      trailing: Icon(Icons.more_vert),
                      hoverColor: Color(0xFF62929E),
                    ),
                  ),
                  Container(
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
                      title: Text('Item 1'),
                      subtitle: Text('Item description'),
                      trailing: Icon(Icons.more_vert),
                      hoverColor: Color(0xFF62929E),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF62929e),
        foregroundColor: Color(0xFFFDFDFF),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage())
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF393d3f),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedNav = NavBar.Home;
                });
              },
              icon: Icon(
                Icons.home,
                  color: selectedNav == NavBar.Home
                      ? Color(0xFF62929E)
                      : Color(0xFFC6C5B9),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedNav = NavBar.Analytics;
                });
                var db = DatabaseManager();
                db.retrieveTxn().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalyticsPage(lis: value,))
                  );
                });
              },
              icon: Icon(
                Icons.pie_chart,
                color: selectedNav == NavBar.Analytics
                    ? Color(0xFF62929E)
                    : Color(0xFFC6C5B9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  ReusableCard({required this.color, required this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardChild,
    );
  }
}
