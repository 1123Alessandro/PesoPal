import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peso_pal/constants.dart';

import 'Analytics.dart';
import 'ViewRecords.dart';


enum NavBar {Home, Analytics}
const activeCardColor = Color(0xFFC6C5B9);

class HomePage extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomePage> {
  NavBar selectedNav = NavBar.Home;
  double totalIncome = 0;
  double totalExpenses = 0;
  double totalBalance = 0;

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
                children: <Widget>[
                  Text('Total Balance'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('PHP'),
                      Text('$totalBalance'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDFDFF),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.arrowtriangle_up_fill,
                                  size: 20.0,
                                  color: incomeArrowIn,
                                ),
                                Text('Income'),
                              ],
                            ),
                            Text('$totalIncome'),
                          ],
                        ),
                      ),
                      Container(
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDFDFF),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.arrowtriangle_down_fill,
                                  size: 20.0,
                                  color: expensesArrowIn,
                                ),
                                Text('Expenses'),
                              ],
                            ),
                            Text('$totalExpenses'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: activeCardColor,
              cardChild: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Transactions'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewPage())
                          );
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
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
        onPressed: () {},
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage())
                );
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
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardChild,
    );
  }
}
