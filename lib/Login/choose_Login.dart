import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Admin_login.dart';
import 'professor_login.dart';
import 'student_login.dart';

class ChooseLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseLoginPage();
  }
}

class ChooseLoginPage extends State<ChooseLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF2E2E2E),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image.asset('img/logo.png'),
                  flex: 2,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Card(
                            color: Colors.blue,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FlatButton(
                                child: Text(
                                  " admin",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              18,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminLogin()));
                                },
                              ),
                            )),
                        Card(
                            color: Colors.blue,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FlatButton(
                                child: Text(
                                  "Professor",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              18,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfessorLogin()));
                                },
                              ),
                            )),
                        Card(
                            color: Colors.blue,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FlatButton(
                                child: Text(
                                  "Student",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              18,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentLogin()));
                                },
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
