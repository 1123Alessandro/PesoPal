import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pesopal/Transaction.dart';
import 'constants.dart';
import 'TxnType.dart';
import 'DatabaseManager.dart';

const activeCardColor = Color(0xFFC6C5B9);
String transactionName = '';
String transactionDate = '';
int transactionPrice = 0;
//final List<Map> items = List<String>.generate(10000, (i) => '$i');

class HistoryPage extends StatefulWidget {

  List<Map> lis;

  HistoryPage({required this.lis});

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState(items: this.lis);
}

class _TransactionHistoryState extends State<HistoryPage> {

  List<Map> items;
  _TransactionHistoryState({required this.items});

  TxnType type = TxnType.Earn;
  // List<String> items = List<String>.generate(10, (i) => '$i');
  //_TransactionHistoryState({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.dns,
          color: Color(0xFF62929E),
        ),
        title: Container(
          child: Text(
            'TRANSACTION HISTORY',
            style: TextStyle(
              color: Color(0xFF546A7B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Color(0xFF62929E),
            ),
            // TODO: select record when clicked
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var currItem = items[index];
            print(currItem['type']);
            print(currItem['type'] == 'Earn');
            if(currItem['type'] == 'Earn') {
              return ListTile(
                leading:
                Icon(
                  CupertinoIcons.arrowtriangle_up_fill,
                  size: 30.0,
                  color: incomeArrowIn,
                ),
                title: Text(currItem['name']),
                subtitle: Text(currItem['date']),
                trailing: Text('Php ${currItem['price'].toString()}'),
              );
            }
            else {
              return ListTile(
                leading:
                Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  size: 30.0,
                  color: expensesArrowIn,
                ),
                title: Text(currItem['name']),
                subtitle: Text(currItem['date']),
                trailing: Text('Php ${currItem['price'].toString()}'),
              );
            }
          },
        )
          // TODO: depends on the number of records
          // TODO: change Expanded

          // TODO: add Previous and Next TextButtons
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
                Icons.delete,
                color: Color(0xFF62929e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class ReusableCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Text text;
  final Widget leading;

  ReusableCard({required this.color, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
          icon,
          size: 20.0,
          color: color,
      ),
      title: Text(transactionName),
      subtitle: Text(transactionDate),
      trailing: Text('$transactionPrice'),
    );
  }
}*/