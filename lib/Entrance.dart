import 'package:flutter/material.dart';

import 'Home.dart';
import 'DatabaseManager.dart';
import 'constants.dart';
import 'Conform.dart';


class WelcomePage extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "PesoPal",
                    style: TextStyle(
                      fontFamily: 'Agrandir',
                      color: Color(0xFF546A7B),
                      fontWeight: FontWeight.w600,
                      fontSize: 50.0,
                    ),
                  ),
                  Text(
                    "Your peso's best pal.",
                    style: TextStyle(
                      fontFamily: 'Agrandir',
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 150.0),
                  Image(
                    image: AssetImage(
                      'assets/images/money_transfer.png',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              hasBeenPressed = !hasBeenPressed;
                            });
                            DatabaseManager().dashBoard().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage(dash: (value[0].length <= 1) ? conformDash(value[0]) : value[0], recs: conformRecs(value[1]),))
                              );
                            });
                          },
                          child: Text(
                            'Start',
                            style: TextStyle(
                              fontFamily: 'Agrandir',
                              fontWeight: FontWeight.w400,
                              fontSize: 30.0,
                              color: Color(0xFF546A7B),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: hasBeenPressed ? Color(0xFF393D3F) : Color(0xFFFFFFFF),
                            padding: EdgeInsets.all(15),
                            side: BorderSide(color: Color(0xFF546A7B)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}