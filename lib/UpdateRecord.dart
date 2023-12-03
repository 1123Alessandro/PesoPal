import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'AddRecord.dart';
import 'TransactionHistory.dart';
import 'constants.dart';
import 'DatabaseManager.dart';
import 'Earn.dart';
import 'Expense.dart';
import 'TxnType.dart';

class UpdatePage extends StatefulWidget {

  String trenID;
  UpdatePage({required this.trenID});

  @override
  _UpdateRecordState createState() => _UpdateRecordState(trenID: trenID);
}

class _UpdateRecordState extends State<UpdatePage> {
  String trenID;
  _UpdateRecordState({required this.trenID});

  TxnType selectedType = TxnType.Earn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF393D3F),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.post_add,
                color: Color(0xFF62929E),
              ),
            ),
            Text(
              'UPDATE RECORD',
              style: TextStyle(
                fontFamily: 'Agrandir',
                fontSize: 21.0,
                color: Color(0xFF393D3F),
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.cached),
              color: Color(0xFF393D3F),
              onPressed: () {
                /*nameController.clear();
                  dateController.clear();
                  priceController.clear();*/
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Reset Update"),
                    content: const Text("Are you sure you want to restart your edit progress?"),
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
                          nameController.clear();
                          dateController.clear();
                          priceController.clear();
                          Navigator.of(ctx).pop();
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
            ),
          ],
        ),
        actions: [
          TextButton(
              child: Icon(Icons.check, color: Color(0xFF62929E)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  DatabaseManager dbmn = DatabaseManager();
                  dbmn.initializeDatabase();
                  if (selectedType == TxnType.Earn) {
                    print('You selected EARN');
                    print('Txn Name: ${nameController.text}');
                    print('Txn Price: ${priceController.text}');
                    print('Txn Date: ${dateController.text}');
                    print('ADDING TO DATABASE...');
                    Earn rec = Earn(name: nameController.text, price: double.parse(priceController.text), date: DateTime.parse(dateController.text));
                    rec.setID(trenID);
                    dbmn.updateTxn(rec);
                    dbmn.retrieveTxn();
                    DatabaseManager().retrieveTxn().then((value) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HistoryPage(lis: value)), (route) => false);
                    });
                  }
                  else if (selectedType == TxnType.Expense) {
                    print('You selected EXPENSE');
                    print('Txn Name: ${nameController.text}');
                    print('Txn Price: ${priceController.text}');
                    print('Txn Date: ${dateController.text}');
                    print('ADDING TO DATABASE...');
                    Expense rec = Expense(name: nameController.text, price: double.parse(priceController.text), date: DateTime.parse(dateController.text));
                    rec.setID(trenID);
                    dbmn.updateTxn(rec);
                    dbmn.retrieveTxn();
                    DatabaseManager().retrieveTxn().then((value) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HistoryPage(lis: value)), (route) => false);
                    });
                  }
                  else {
                    print('ERROR: Please select an expense type');
                    dbmn.retrieveTxn();
                  }
                }
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    cursorColor: Color(0xFF546A7B),
                    style: TextStyle(
                      color: Color(0xFF393D3F),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Transaction Name',
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                      border: myInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = TxnType.Earn;
                            DatabaseManager().retrieveTxn();
                            // DatabaseManager().retrieveTxn().then((value) {
                            //   print(selectedType);
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                            // });
                          });
                        },
                        child: Expanded(
                          child: ReusableCard(
                            color: selectedType == TxnType.Earn
                                ? Color(0xFF546A7B)
                                : Color(0xFF62929E),
                            cardChild: Text("Earn",
                              style: TextStyle(color: text2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = TxnType.Expense;
                            // DatabaseManager().createSamples();
                          });
                        },
                        child: Expanded(
                          child: ReusableCard(
                            color: selectedType == TxnType.Expense
                                ? Color(0xFF546A7B)
                                : Color(0xFF62929E),
                            cardChild: Text("Expense",
                              style: TextStyle(color: text2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: dateController,
                    cursorColor: Color(0xFF546A7B),
                    style: TextStyle(
                      color: Color(0xFF393D3F),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Transaction Date',
                      prefixIcon: Icon(
                        Icons.calendar_month,
                      ),
                      border: myInputBorder(),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        setState(() {
                          dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursorColor: Color(0xFF546A7B),
                    style: TextStyle(
                      color: Color(0xFF393D3F),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Transaction Amount',
                      prefixIcon: Icon(
                        Icons.money,
                      ),
                      border: myInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
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
      padding: EdgeInsets.all(15.0),
      width: 150.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardChild,
    );
  }
}

OutlineInputBorder myInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Color(0xFFC6C5B9),
      width: 1,
    ),
  );
}
