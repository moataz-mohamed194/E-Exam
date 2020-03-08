import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Admin_login.dart';
import 'professor_login.dart';
import 'student_login.dart';

class Chooselogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseLoginPage();
  }
}

class ChooseLoginPage extends State<Chooselogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: FlatButton(
                            child: Text(
                              "Student",
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentLogin()));
                            },
                          ),
                        ),
                        Card(
                          child: FlatButton(
                            child: Text(
                              " admin",
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminLogin()));
                            },
                          ),
                        ),
                        Card(
                          child: FlatButton(
                            child: Text(
                              "Professor",
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfessorLogin()));

                              print("xxxxxxx");
                            },
                          ),
                        )
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
