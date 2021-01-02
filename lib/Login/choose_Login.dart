import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Admin_login.dart';
import 'professor_login.dart';
import 'student_login.dart';
import 'package:get/get.dart';
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
                Container(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    child: Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LanguageView(),
                            fullscreenDialog: true),
                      );
                    },
                  ),
                ),
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
                                child:
                                Text("firstButtonInChooseLogin".trArgs(),
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
                                    "secondButtonInChooseLogin".trArgs(),
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

                                  "thirdButtonInChooseLogin".trArgs(),
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
