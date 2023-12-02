import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'Home.dart';
import 'constants.dart';
import 'DatabaseManager.dart';

enum NavBar {Home, Analytics}
const activeCardColor = Color(0xFFC6C5B9);

class AnalyticsPage extends StatefulWidget {
  List<Map> lis;

  AnalyticsPage({required this.lis});

  @override
  _AnalyticsState createState() => _AnalyticsState(items: this.lis);
}

class _AnalyticsState extends State<AnalyticsPage> {
  List<Map> items;
  _AnalyticsState({required this.items});
  NavBar selectedNav = NavBar.Analytics;

  List<Map> getItemsList() {
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Color(0xFF62929E),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Text(
                'Expenses',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Color(0xFF62929E),
                ),
              ),
            ],
          ),
          title: Text(
              'ANALYTICS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Agrandir',
                color: Color(0xFF393D3F),
                fontWeight: FontWeight.bold,
              ),
            ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ReusableCard(
                color: activeCardColor,
                cardChild: PieChartContent(items: getItemsList()),
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: activeCardColor,
                cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(var item in getListTile(items)) item
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
                  DatabaseManager().dashBoard().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(dash: (value.length <= 1) ? nones : value,))
                    );
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

class PieChartContent extends StatelessWidget {
  List<Map> items;
  PieChartContent({required this.items});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 0,
        sectionsSpace: 0,
          sections: getSectionData(MediaQuery.of(context).size.width,items),
      ),
    );
  }
}

List<Color> sectionColors = [
  Color(0xFF141F2B),
  Color(0xFF223140),
  Color(0xFF3D5D7B),
  Color(0xFF506981),
  Color(0xFF62929E),
];

List<PieChartSectionData> getSectionData(double screenWidth, List<Map> items) {
  double radius = screenWidth / 4.44;

  List<Map<String, dynamic>> listCopy = List.of(items as Iterable<Map<String, dynamic>>);
  List<Map<String, dynamic>> expenseItems =
  listCopy.where((item) => item['type'] == 'Expense').toList();

  expenseItems.sort((a, b) => b['price'].compareTo(a['price']));

  double totalPriceSum = 0;
  for (var i = 0; i < expenseItems.length && i < 5; i++) {
    totalPriceSum += listCopy[i]['price'];
  }

  List<PieChartSectionData> sectionData = [];
  for (var i = 0; i < expenseItems.length && i < 5; i++) {
    double percentage = (expenseItems[i]['price'] / totalPriceSum) * 100;
    Color sectionColor = sectionColors[i % sectionColors.length];
    sectionData.add(
      PieChartSectionData(
        value: expenseItems[i]['price'].toDouble(),
        title: '${percentage.toStringAsFixed(2)}%',
        radius: radius,
        color: sectionColor,
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  return sectionData;
}

List<ListTile> getListTile(List<Map> items) {
  List<Map<String, dynamic>> listCopy = List.of(items as Iterable<Map<String, dynamic>>);
  List<Map<String, dynamic>> expenseItems =
  listCopy.where((item) => item['type'] == 'Expense').toList();

  expenseItems.sort((a, b) => b['price'].compareTo(a['price']));

  List<ListTile> tile = [];
  for (var i = 0; i < expenseItems.length && i < 5; i++) {
    Color iconColor = sectionColors[i % sectionColors.length];
    tile.add(
      ListTile(
        leading: Icon(
          Icons.square,
          size: 15.0,
          color: iconColor,
        ),
        title: Text(
          expenseItems[i]['name'],
          style: TextStyle(
            fontFamily: 'Agrandir',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  return tile;
}
