import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

import 'Analytics.dart';
import 'TransactionHistory.dart';
import 'DatabaseManager.dart';


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
  // double totalBalance = 0;

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
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Icon(
            Icons.account_circle_rounded,
            color: Color(0xFF393D3F),
            size: 50,
          ),
        ),
        title: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 2.5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome back,',
                  style: TextStyle(
                    color: Color(0xFF0A090C),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Juan dela Cruz!',
                  style: TextStyle(
                    color: Color(0xFF546A7B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // TODO: fix layout inside the first Expanded widget
      body: Column(
        children: <Widget>[
          Expanded(
            child: ReusableCard(
              color: activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Balance',
                    style: TextStyle(
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
                          fontWeight: FontWeight.w800,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        '${totalIncome - totalExpenses}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
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
                                      width: 10.0,
                                      height: 20.0,
                                    ),
                                    Text(
                                      '$totalIncome',
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
                                    width: 10.0,
                                    height: 20.0,
                                  ),
                                  Text(
                                    '$totalExpenses',
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HistoryPage())
                          // );
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            decoration: TextDecoration.underline,
                          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF62929e),
        foregroundColor: Color(0xFFFDFDFF),
        onPressed: () {
          print('hello po');
          // DatabaseManager().dashBoard().then((value) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => HomePage())
          //   );
          // });
          // db.retrieveTxn().then((value) {
          // Navigator.push(
          // context,
          // MaterialPageRoute(builder: (context) => HistoryPage(lis: value,))
          // );
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomePage())
                // );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnalyticsPage())
                );
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
