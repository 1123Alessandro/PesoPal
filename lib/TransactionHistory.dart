import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pesopal/AddRecord.dart';
import 'Transaction.dart';
import 'constants.dart';
import 'TxnType.dart';
import 'DatabaseManager.dart';
import 'Home.dart';
import 'EditRecord.dart';
import 'main.dart';
import 'UpdateRecord.dart';


const activeCardColor = Color(0xFFC6C5B9);
String transactionName = '';
String transactionDate = '';
int transactionPrice = 0;
//final List<Map> items = List<String>.generate(10000, (i) => '$i');
int selected = 0;

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePage(trenID: items[selected]['id'].toString(),))
              );
              /*var db = DatabaseManager();
              db.createSamples();
              db.retrieveTxn().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPage(lis: value,))
                );
              });*/
            },
          ),
        ],
      ),
      body: Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var currItem = items[index];
              // print(currItem['type']);
              // print(currItem['type'] == 'Earn');
              if(currItem['type'] == 'Earn') {
                return ListTile(
                    tileColor: selected == index? Color(0xFF62929E) : Color(0xFFFFFFFF),
                    leading: Icon(
                      CupertinoIcons.arrowtriangle_up_fill,
                      size: 30.0,
                      color: incomeArrowIn,
                    ),
                    title: Text(currItem['name']),
                    subtitle: Text(currItem['date']),
                    trailing: Text('PHP ${currItem['price'].toString()}'),
                    hoverColor: Color(0xFF62929E),
                    onTap: () {
                      setState(() {
                        selected = index;
                        print('YOU HAVE SELECTED THIS RECORD');
                        print(items[selected]);
                      });
                    }
                );
              }
              else {
                return ListTile(
                  tileColor: selected == index? Color(0xFF62929E) : Color(0xFFFFFFFF),
                  leading: Icon(
                    CupertinoIcons.arrowtriangle_down_fill,
                    size: 30.0,
                    color: expensesArrowIn,
                  ),
                  title: Text(currItem['name']),
                  subtitle: Text(currItem['date']),
                  trailing: Text('Php ${currItem['price'].toString()}'),
                  hoverColor: Color(0xFF62929E),
                  onTap: () {
                    setState(() {
                      selected = index;
                      print('YOU HAVE SELECTED THIS RECORD');
                      print(items[selected]);
                    });
                  }
                );
              }
            },
          )
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
                DatabaseManager().dashBoard().then((value) {
                  print('JJJJJJJJJJJJJSKDJFLSKDJFJ');
                  print(value.length);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(dash: (value.length <= 1) ? nones : value,))
                  );
                });
              },
              icon: Icon(
                Icons.home,
                color: Color(0xFF62929e),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Record"),
                    content: const Text("Are you sure you want to remove this record?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Color(0xFF546A7B),
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "No",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF)
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          print('DELETING RECORD');
                          var record = items[selected];
                          print(record);
                          DatabaseManager().deleteTxn(record['id']).then((value) {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HistoryPage(lis: value)), (route) => false);
                          });
                          // var db = DatabaseManager();
                          // db.retrieveTxn().then((value) {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => HistoryPage(lis: value,))
                            // );
                          //   print('CAN YOU PLEASE LOOK AT ME');
                          //   print(value);
                          //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HistoryPage(lis: value)), (route) => false);
                          // });
                          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);
                          // DatabaseManager().dashBoard().then((value) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HomePage(dash: (value.length < 1) ? nones : value,))
                          //   );
                          // });
                        },
                        child: Container(
                          color: Color(0xFF546A7B),
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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

class ReusableCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Text text;

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
}