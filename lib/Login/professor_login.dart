import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'signupforprofessor.dart';

import 'package:http/http.dart' as http;

class ProfessorLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfessorLoginPage();
  }
}

class ProfessorLoginPage extends State<ProfessorLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode professorIdNode = FocusNode();
  final FocusNode professorPasswordNode = FocusNode();
  TextEditingController professorId;
  TextEditingController professorPassword;
  String professorIdSave, professorPasswordSave;
  void initState() {
    super.initState();
    professorId = new TextEditingController();
    professorPassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  GlobalState _store = GlobalState.instance;

  List data = new List();
  var response;
  //send http request and get the data from professor table Dependent on email you entered
  login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = "http://${_store.ipAddress}/app/professor.php";
      response = await http.post(url, body: {
        "action": "check_your_email_and_password",
        "email": "$id",
      });
      String content = response.body;
      setState(() {
        data = json.decode(content);
      });
      if (password == data[0]['Password']) {
        prefs.setString('ID', "${data[0]['ID']}");
        prefs.setString('Nationalid', "${data[0]['Nationalid']}");
        prefs.setString('Email', "${data[0]['Email']}");
        prefs.setString('Password', "${data[0]['Password']}");
        prefs.setString('realName', "${data[0]['realName']}");
        prefs.setString('graduted', "${data[0]['graduted']}");
        prefs.setString('age', "${data[0]['age']}");
        prefs.setString('loginasprofessor', "yes");
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/mainprofessor', (Route<dynamic> route) => false);

        Toast.Toast.show("Welcome to our app", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      } else {
        Toast.Toast.show("Check your password ", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      }
    } catch (e) {
      Toast.Toast.show("Check your  Email", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    }
  }

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Color(0xFF2E2E2E),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset('img/logo.png'),
              flex: 1,
            ),
            Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 40),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: professorId,
                            focusNode: professorIdNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorIdSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, professorIdNode,
                                  professorPasswordNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Your Email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: "Enter your Email",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your Email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 40),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: professorPassword,
                              focusNode: professorPasswordNode,
                              textInputAction: TextInputAction.done,
                              onSaved: (input) => professorPasswordSave = input,
                              onFieldSubmitted: (value) {
                                professorPasswordNode.unfocus();
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: "Your Password",
                                hintText: "Enter your Password",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Password';
                                } else if (value.length < 6) {
                                  return 'Your Password must be longer than 6 numbers';
                                } else {
                                  return null;
                                }
                              },
                            ))
                      ],
                    ),
                  ),
                  Card(
                      color: Colors.blue,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          child: Text("Login as Professor",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              scaffoldState.currentState
                                  .showSnackBar(new SnackBar(
                                content: Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("Loading ...")
                                  ],
                                ),
                              ));

                              login(professorId.text, professorPassword.text);
                            }
                          },
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        right: 15,
                        bottom: MediaQuery.of(context).size.height / 40),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text(
                        "sgin up ",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessorSignUp()));
                      },
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
