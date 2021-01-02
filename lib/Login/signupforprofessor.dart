import 'package:get/get.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
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
      Toast.Toast.show(
          "thisNationalIdIsUsed".trArgs() ,
          context,
          duration: Toast.Toast.LENGTH_SHORT,
          gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "email used") {
      Toast.Toast.show(
          "thisEmailIsUsed".trArgs() ,
          context,
          duration: Toast.Toast.LENGTH_SHORT,
          gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "Done") {
      Navigator.pop(context);
      Toast.Toast.show(
          "yourRequestIsAdded".trArgs() ,
          context,
          duration: Toast.Toast.LENGTH_SHORT,
          gravity: Toast.Toast.BOTTOM);
    }
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
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15),
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
                              labelText:
                                  "yourID".trArgs(), //AppLocalizations.of(context).tr('yourID'),
                              hintText:
                                  "enterYourID".trArgs() ,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enterYourID".trArgs() ;
                              } else if (value.length < 6) {
                                return "yourIDMustBeLongerThan6Numbers".trArgs() ;
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
                              labelText:
                                  "yourEmail".trArgs(),
                              hintText:
                                  "enterYourEmail".trArgs() ,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enterYourEmail".trArgs() ;
                              } else if (!value.contains("@")) {
                                return "yourEmailMustContain".trArgs();
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
                              labelText:
                                  "yourPassword".trArgs() ,
                              hintText:
                                  "enterYourPassword".trArgs(),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enterYourPassword".trArgs() ;
                              } else if (value.length < 6) {
                                return "yourPasswordMustBeLongerThan6Numbers".trArgs() ;
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
                              labelText:
                                  "yourAge".trArgs() ,
                              hintText:
                                  "enterYourAge".trArgs() ,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enterYourAge".trArgs();
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
                              labelText:
                                  "yourGraduated".trArgs(),
                              hintText:
                                  "enterYourGraduated".trArgs(),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enterYourGraduated".trArgs();
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
                                labelText:
                                    "yourName".trArgs() ,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText:
                                    "enterYourName".trArgs(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "enterYourName".trArgs() ;
                                } else if (value.length < 7) {
                                  return "yourNameMustBeLonger".trArgs();
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
                              "buttonLogin".trArgs(),
                              // AppLocalizations.of(context).tr('buttonLogin'),
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
                                child: Text(
                                    "pageSignUpAsProfessor".trArgs() ,
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
