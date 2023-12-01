import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:intl/intl.dart';

import 'Transaction.dart';
import 'DatabaseManager.dart';
import 'Earn.dart';
import 'Expense.dart';
import 'TxnType.dart';

const activeCardColor = Color(0xFFC6C5B9);
final nameController = TextEditingController();
final dateController = TextEditingController();
final priceController = TextEditingController();
final typeController = TextEditingController();

class AddPage extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddPage> {
  TxnType selectedType = TxnType.None;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF393D3F),
            onPressed: () {},
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
                'ADD RECORD',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.cached),
                color: Color(0xFF393D3F),
                onPressed: () {},
              ),
            ],
          ),
          actions: [
            /*IconButton(
              icon: Icon(Icons.check),
              color: Color(0xFF62929E),
              onPressed: () {},
            ),*/
            TextButton(
                child: Icon(Icons.check, color: Color(0xFF62929E)),
                onPressed: () {
                  /* if(typeController.text == 'Earn') {
                            DatabaseManager.instance.insertTxn(Earn(
                                name: nameController.text,
                                price: priceController.text,
                                date: dateController.text));
                            Navigator.pop(context, "Your todo has been saved.");
                          }
                          else {
                            DatabaseManager.instance.insertTxn(Expense(
                                name: nameController.text,
                                price: priceController.text,
                                date: dateController.text));
                            Navigator.pop(context, "Your todo has been saved.");
                          }*/
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Form(
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
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = TxnType.Earn;
                              print('EARN selected');
                            });
                          },
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = TxnType.Expense;
                              print('EXPENSE selected');
                            });
                          },
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
                      ],
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: dateController,
                      /*inputFormatters: [
                        // TODO: try a dropdown box for date input
                        // MaskTextInputFormatter(
                        //   mask: '####-##-##',
                        //   filter: {'#': RegExp(r'[0-9]')}
                        // ),
                      ],*/
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
                            lastDate: DateTime(2025));

                        if (pickedDate != null) {
                          setState(() {
                            dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
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
                        // TODO: check if it works on only digits
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      cursorColor: Color(0xFF546A7B),
                      style: TextStyle(
                        color: Color(0xFF393D3F),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Transaction Amouunt',
                        prefixIcon: Icon(
                          Icons.money,
                        ),
                        border: myInputBorder(),
                      ),
                    ),
                    // TextFormField(
                    //   cursorColor: Color(0xFF546A7B),
                    //   style: TextStyle(
                    //     color: Color(0xFF393D3F),
                    //   ),
                    //   decoration: InputDecoration(
                    //     labelText: 'Name of Transaction',
                    //     enabledBorder: myInputBorder(),
                    //     focusedBorder: myFocusBorder(),
                    //     hintStyle: TextStyle(
                    //       color: Color(0xFF546A7B),
                    //     ),
                    //     filled: false,
                    //     fillColor: Color(0xFFE8E8E8),
                    //     prefixIcon: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //       child: Align(
                    //         widthFactor: 1.0,
                    //         heightFactor: 1.0,
                    //         child: Icon(
                    //           Icons.description,
                    //           color: Color(0xFFC6C5B9),
                    //         ),
                    //       ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.datetime,
                    //   inputFormatters: [
                    //     // TODO: try a dropdown box for date input
                    //     // MaskTextInputFormatter(
                    //     //   mask: '####-##-##',
                    //     //   filter: {'#': RegExp(r'[0-9]')}
                    //     // ),
                    //   ],
                    //   cursorColor: Color(0xFF546A7B),
                    //   style: TextStyle(
                    //     color: Color(0xFF393D3F),
                    //   ),
                    //   decoration: InputDecoration(
                    //     labelText: 'Date of Transaction',
                    //     enabledBorder: myInputBorder(),
                    //     focusedBorder: myFocusBorder(),
                    //     hintStyle: TextStyle(
                    //       color: Color(0xFF546A7B),
                    //     ),
                    //     filled: false,
                    //     fillColor: Color(0xFFE8E8E8),
                    //     prefixIcon: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //       child: Align(
                    //         widthFactor: 1.0,
                    //         heightFactor: 1.0,
                    //         child: Icon(
                    //           Icons.calendar_month,
                    //           color: Color(0xFFC6C5B9),
                    //         ),
                    //       ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   inputFormatters: [
                    //     // TODO: check if it works on only digits
                    //     FilteringTextInputFormatter.digitsOnly,
                    //   ],
                    //   cursorColor: Color(0xFF546A7B),
                    //   style: TextStyle(
                    //     color: Color(0xFF393D3F),
                    //   ),
                    //   decoration: const InputDecoration(
                    //     hintText: 'Amount',
                    //     hintStyle: TextStyle(
                    //       color: Color(0xFF546A7B),
                    //     ),
                    //     filled: false,
                    //     fillColor: Color(0xFFE8E8E8),
                    //     prefixIcon: Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 10.0),
                    //       child: Align(
                    //         widthFactor: 1.0,
                    //         heightFactor: 1.0,
                    //         child: Icon(
                    //           Icons.money,
                    //           color: Color(0xFFC6C5B9),
                    //         ),
                    //       ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    FloatingActionButton(
                        child: Icon(Icons.check),
                        onPressed: () {
                          DatabaseManager dbmn = DatabaseManager();
                          dbmn.initializeDatabase();
                          if (selectedType == TxnType.Earn) {
                            print('You selected EARN');
                            print('Txn Name: ${nameController.text}');
                            print('Txn Price: ${priceController.text}');
                            print('Txn Date: ${dateController.text}');
                            print('ADDING TO DATABASE...');
                            dbmn.insertTxn(Earn(name: nameController.text, price: double.parse(priceController.text), date: DateTime.parse(dateController.text)));
                          }
                          else if (selectedType == TxnType.Expense) {
                            print('You selected EXPENSE');
                            print('Txn Name: ${nameController.text}');
                            print('Txn Price: ${priceController.text}');
                            print('Txn Date: ${dateController.text}');
                            print('ADDING TO DATABASE...');
                            dbmn.insertTxn(Expense(name: nameController.text, price: double.parse(priceController.text), date: DateTime.parse(dateController.text)));
                          }
                          else {
                            print('ERROR: Please select an expense type');
                            dbmn.retrieveTxn();
                          }

                         /* if(typeController.text == 'Earn') {
                            DatabaseManager.instance.insertTxn(Earn(
                                name: nameController.text,
                                price: priceController.text,
                                date: dateController.text));
                            Navigator.pop(context, "Your todo has been saved.");
                          }
                          else {
                            DatabaseManager.instance.insertTxn(Expense(
                                name: nameController.text,
                                price: priceController.text,
                                date: dateController.text));
                            Navigator.pop(context, "Your todo has been saved.");
                          }*/
                        }),
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
      height: 50,
      width: 180,
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
//
// OutlineInputBorder myFocusBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(10)),
//     borderSide: BorderSide(
//       color: Color(0xFFC6C5B9),
//       width: 1,
//     ),
//   );
// }
