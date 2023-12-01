import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const activeCardColor = Color(0xFFC6C5B9);

class AddPage extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddPage> {
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
                color: Color(0xFF546A7B),
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
          IconButton(
            icon: Icon(Icons.check),
            color: Color(0xFF62929E),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Form(
              child: Column(
                children: [
                  TextFormField(
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
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      // TODO: try a dropdown box for date input
                      // MaskTextInputFormatter(
                      //   mask: '####-##-##',
                      //   filter: {'#': RegExp(r'[0-9]')}
                      // ),
                    ],
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
                  ),
                  TextFormField(
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
  ReusableCard({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
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
