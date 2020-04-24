import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class ProfessorSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfessorSignUpPage();
  }
}

class ProfessorSignUpPage extends State<ProfessorSignUp> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode professorIdNode = FocusNode();
  final FocusNode professorEmailNode = FocusNode();
  final FocusNode professorNameNode = FocusNode();
  final FocusNode professorAgeNode = FocusNode();
  final FocusNode professorGraduatedNode = FocusNode();
  final FocusNode professorPasswordNode = FocusNode();
  TextEditingController professorId;
  TextEditingController professorName;
  TextEditingController professorEmail;
  TextEditingController professorAge;
  TextEditingController professorGraduated;
  TextEditingController professorPassword;
  String professorIdSave,
      professorPasswordSave,
      professorNameSave,
      professorEmailSave,
      professorAgeSave,
      professorGraduatedSave;
  void initState() {
    super.initState();
    professorId = new TextEditingController();
    professorName = new TextEditingController();
    professorEmail = new TextEditingController();
    professorAge = new TextEditingController();
    professorGraduated = new TextEditingController();
    professorPassword = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //send your request to database
  signUp(String name, String email, String id, String password,
      String graduated, String age) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final request = await http.post(url, body: {
      "action": "send_request",
      "type": "Professor",
      "Nationalid": "$id",
      "Email": email,
      "Password": password,
      "realName": name,
      "graduted": graduated,
      "age": age
    }).catchError((e) {
      print(e);
    });
    print(request.body);
    if (request.body == "Nationalid used") {
      Toast.Toast.show("this national id is used", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "email used") {
      Toast.Toast.show("this email is used", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "Done") {
      Navigator.pop(context);
      Toast.Toast.show("your request is added", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    }
    /*.whenComplete(() {
      Toast.Toast.show("Your request is send", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);

      Navigator.pop(context);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E2E2E),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset('img/logo.png'),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: professorId,
                            focusNode: professorIdNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorIdSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, professorIdNode, professorEmailNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your ID",
                              hintText: "Enter your ID",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your ID';
                              } else if (value.length < 6) {
                                return 'Your ID must be longer than 6 numbers';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: professorEmail,
                            focusNode: professorEmailNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorEmailSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, professorEmailNode,
                                  professorPasswordNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your email",
                              hintText: "Enter your email",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your email';
                              } else if (!value.contains("@")) {
                                return 'Your Email must contain @';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: professorPassword,
                            focusNode: professorPasswordNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorPasswordSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, professorPasswordNode,
                                  professorAgeNode);
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
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: professorAge,
                            focusNode: professorAgeNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorAgeSave = input,
                            onFieldSubmitted: (value) {
                              _fieldFocusChange(context, professorAgeNode,
                                  professorGraduatedNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your Age",
                              hintText: "Enter your Age",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your Age';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: professorGraduated,
                            focusNode: professorGraduatedNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => professorGraduatedSave = input,
                            onFieldSubmitted: (value) {
                              _fieldFocusChange(context, professorGraduatedNode,
                                  professorNameNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your graduated",
                              hintText: "Enter your graduated",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your graduated';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: professorName,
                              focusNode: professorNameNode,
                              textInputAction: TextInputAction.done,
                              onSaved: (input) => professorNameSave = input,
                              onFieldSubmitted: (value) {
                                professorNameNode.unfocus();
                              },
                              decoration: InputDecoration(
                                labelText: "Your name",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: "Enter your name",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Your name';
                                } else if (value.length < 7) {
                                  return 'Your Name must be longer';
                                } else {
                                  return null;
                                }
                              },
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15,
                              bottom: MediaQuery.of(context).size.height / 40),
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Text(
                              "login ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Card(
                            color: Colors.blue,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FlatButton(
                                child: Text("sign up Professor",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    signUp(
                                        professorName.text,
                                        professorEmail.text,
                                        professorId.text,
                                        professorPassword.text,
                                        professorGraduated.text,
                                        professorAge.text);
                                  }
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
