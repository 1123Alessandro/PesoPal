import 'package:flutter/material.dart';

const activeCardColor = Color(0xFFC6C5B9);

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Color(0xFF62929E),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.arrow_upward,
                  color: Color(0xFF393D3F),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.arrow_downward,
                  color: Color(0xFF393D3F),
                ),
              ),
            ],
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'ANALYTICS',
              style: TextStyle(
                color: Color(0xFF546A7B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // TODO: add charts in the Expanded Widgets
        body: TabBarView(
          children: [
            // Income() tab
            Column(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: activeCardColor,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: activeCardColor,
                  ),
                ),
              ],
            ),
            // Expenses() tab
            Column(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: activeCardColor,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: activeCardColor,
                  ),
                ),
              ],
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
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: Color(0xFF62929e),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.pie_chart,
                  color: Color(0xFF62929e),
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
  ReusableCard({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
