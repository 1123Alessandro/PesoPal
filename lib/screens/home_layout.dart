import 'package:flutter/material.dart';

const activeCardColor = Color(0xFFC6C5B9);

class HomePage extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomePage> {
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
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: activeCardColor,
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
