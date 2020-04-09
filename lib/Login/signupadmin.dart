import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class Adminsignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminsignupPage();
  }
}

class AdminsignupPage extends State<Adminsignup> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Adminemailnode = FocusNode();
  final FocusNode Adminnamenode = FocusNode();
  final FocusNode Adminnationalidnode = FocusNode();
  final FocusNode Adminpasswordnode = FocusNode();
  final FocusNode Admingradutednode = FocusNode();
  final FocusNode Adminagenode = FocusNode();
  TextEditingController Adminemail;
  TextEditingController Adminname;
  TextEditingController Admingraduted;
  TextEditingController Adminage;
  TextEditingController Adminnationalid;
  TextEditingController Adminpassword;
  String Adminemailsave,
      Adminpasswordsave,
      Admingradutedsave,
      Adminagesave,
      Adminnamesave,
      Adminnationalidsave;
  void initState() {
    super.initState();
    Adminemail = new TextEditingController();
    Adminname = new TextEditingController();
    Adminnationalid = new TextEditingController();
    Admingraduted = new TextEditingController();
    Adminage = new TextEditingController();
    Adminpassword = new TextEditingController();
    getadmindata();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  GlobalState _store = GlobalState.instance;

  List data = new List();
  void getadmindata() async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getadmindata2"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    print("0000" + response.body);
    print("1111" + data.toString());
    return json.decode(response.body);
  }

  sendData(String national, String name, String email, String password,
      String graduted, String age) async {
    //  try {
    for (int i = 0; i < data.length; i++) {
      if (national == data[i]['Nationalid'] || email == data[i]['Email']) {
        Toast.Toast.show("that eamil or your id is used", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        return 0;
      }
    }
    var url = "http://${_store.ipaddress}/app/admin.php";
    await http.post(url, body: {
      "action": "send_request",
      "type": "Admin",
      "Nationalid": national,
      "Email": email,
      "Password": password,
      "realName": name,
      "graduted": graduted,
      "age": age
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Toast.Toast.show("Your request is send", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);

      Navigator.pop(context);
    });
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
                            controller: Adminnationalid,
                            focusNode: Adminnationalidnode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => Adminnationalidsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Adminnationalidnode, Adminemailnode);
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
                            controller: Adminemail,
                            focusNode: Adminemailnode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => Adminemailsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Adminemailnode, Adminpasswordnode);
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
                            controller: Adminpassword,
                            focusNode: Adminpasswordnode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => Adminpasswordsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, Adminpasswordnode,
                                  Admingradutednode);
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
                            controller: Admingraduted,
                            focusNode: Admingradutednode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => Admingradutedsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Admingradutednode, Adminagenode);
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
                            controller: Adminage,
                            focusNode: Adminagenode,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => Adminagesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Adminagenode, Adminnamenode);
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
                              controller: Adminname,
                              focusNode: Adminnamenode,
                              textInputAction: TextInputAction.done,
                              onSaved: (input) => Adminnamesave = input,
                              onFieldSubmitted: (value) {
                                Adminnamenode.unfocus();
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
                                    /*login(
                                        Adminnationalid.text,
                                        Adminname.text,
                                        Adminemail.text,
                                        Adminpassword.text,
                                        Admingraduted.text,
                                        Adminage.text);*/
                                    sendData(
                                        Adminnationalid.text,
                                        Adminname.text,
                                        Adminemail.text,
                                        Adminpassword.text,
                                        Admingraduted.text,
                                        Adminage.text);
                                    //  print("cccccccccc");
                                  }
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  //    ])
                )
              ],
            ),
          ),
        ));
  }
}
