import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class AdminSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminSignUpPage();
  }
}

class AdminSignUpPage extends State<AdminSignUp> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode adminEmailNode = FocusNode();
  final FocusNode adminNameNode = FocusNode();
  final FocusNode adminNationalIdNode = FocusNode();
  final FocusNode adminPasswordNode = FocusNode();
  final FocusNode adminGraduatedNode = FocusNode();
  final FocusNode adminAgeNode = FocusNode();
  TextEditingController adminEmail;
  TextEditingController adminName;
  TextEditingController adminGraduated;
  TextEditingController adminAge;
  TextEditingController adminNationalId;
  TextEditingController adminPassword;
  String adminEmailSave,
      adminPasswordSave,
      adminGraduatedSave,
      adminAgeSave,
      adminNameSave,
      adminNationalIdSave;
  void initState() {
    super.initState();
    adminEmail = new TextEditingController();
    adminName = new TextEditingController();
    adminNationalId = new TextEditingController();
    adminGraduated = new TextEditingController();
    adminAge = new TextEditingController();
    adminPassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  GlobalState _store = GlobalState.instance;
  //send the request of admin to database
  sendData(String national, String name, String email, String password,
      String graduated, String age) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    var request = await http.post(url, body: {
      "action": "send_request",
      "type": "Admin",
      "Nationalid": national,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2E2E2E),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            controller: adminNationalId,
                            focusNode: adminNationalIdNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => adminNationalIdSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminNationalIdNode, adminEmailNode);
                            },
                            decoration: InputDecoration(
                              labelText: "Your id",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: "Enter your id",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your id';
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
                            controller: adminEmail,
                            focusNode: adminEmailNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => adminEmailSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminEmailNode, adminPasswordNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your Email",
                              hintText: "Enter your Email",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your Email';
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
                            controller: adminPassword,
                            focusNode: adminPasswordNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => adminPasswordSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, adminPasswordNode,
                                  adminGraduatedNode);
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
                            controller: adminGraduated,
                            focusNode: adminGraduatedNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => adminGraduatedSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminGraduatedNode, adminAgeNode);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: "Your graduted",
                              hintText: "Enter your graduted",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your graduted';
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
                            controller: adminAge,
                            focusNode: adminAgeNode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => adminAgeSave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminAgeNode, adminNameNode);
                            },
                            decoration: InputDecoration(
                              labelText: "Your age",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: "Enter your age",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Your age';
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
                              controller: adminName,
                              focusNode: adminNameNode,
                              textInputAction: TextInputAction.done,
                              onSaved: (input) => adminNameSave = input,
                              onFieldSubmitted: (value) {
                                adminNameNode.unfocus();
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: "Your name",
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
                                child: Text("sign up admin",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    sendData(
                                        adminNationalId.text,
                                        adminName.text,
                                        adminEmail.text,
                                        adminPassword.text,
                                        adminGraduated.text,
                                        adminAge.text);
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
          ),
        ));
  }
}
