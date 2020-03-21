import 'package:exam/Database/Database_admin.dart';
import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'professor_login.dart';

class Professorsignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfessorsignupPage();
  }
}

class ProfessorsignupPage extends State<Professorsignup> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Professoridnode = FocusNode();
  final FocusNode Professoremailnode = FocusNode();
  final FocusNode Professornamenode = FocusNode();
  final FocusNode Professoragenode = FocusNode();
  final FocusNode Professorgraduatednode = FocusNode();
  final FocusNode Professorpasswordnode = FocusNode();
  TextEditingController Professorid;
  TextEditingController Professorname;
  TextEditingController Professoremail;
  TextEditingController Professorage;
  TextEditingController Professorgraduated;
  TextEditingController Professorpassword;
  String Professoridsave,
      Professorpasswordsave,
      Professornamesave,
      Professoremailsave,
      Professoragesave,
      Professorgraduatedsave;
  void initState() {
    super.initState();
    Professorid = new TextEditingController();
    Professorname = new TextEditingController();
    Professoremail = new TextEditingController();
    Professorage = new TextEditingController();
    Professorgraduated = new TextEditingController();
    Professorpassword = new TextEditingController();
    getprofessordata();
  }

  List data = new List();
  void getprofessordata() async {
    database_professor().getprofessordata().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  login(String name, String email, int id, String password, String graduated,
      int age) async {
    for (int i = 0; i < data.length; i++) {
      if (id == data[i]['Nationalid'] || email == data[i]['Email']) {
        Toast.Toast.show("that eamil or your id is used", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        return 0;
      }
    }
    database api = new database();
    var l = await api.sendtodatabase1(
        'Professor', name, email, id, password, graduated, age);
    Navigator.pop(context);
    Toast.Toast.show("your request is send", context,
        duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);

    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: Professorid,
                    focusNode: Professoridnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professoridsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Professoridnode, Professoremailnode);
                    },
                    decoration: InputDecoration(
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Professoremail,
                    focusNode: Professoremailnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professoremailsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Professoremailnode, Professorpasswordnode);
                    },
                    decoration: InputDecoration(
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Professorpassword,
                    focusNode: Professorpasswordnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professorpasswordsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Professorpasswordnode, Professoragenode);
                    },
                    decoration: InputDecoration(
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: Professorage,
                    focusNode: Professoragenode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professoragesave = input,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(
                          context, Professoragenode, Professorgraduatednode);
                    },
                    decoration: InputDecoration(
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Professorgraduated,
                    focusNode: Professorgraduatednode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professorgraduatedsave = input,
                    onFieldSubmitted: (value) {
                      _fieldFocusChange(
                          context, Professorgraduatednode, Professornamenode);
                    },
                    decoration: InputDecoration(
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Professorname,
                    focusNode: Professornamenode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Professornamesave = input,
                    onFieldSubmitted: (value) {
                      Professornamenode.unfocus();
                    },
                    decoration: InputDecoration(
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text(
                  "login ",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            FlatButton(
              child: Text(
                "sign up Professor",
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  login(
                      Professorname.text,
                      Professoremail.text,
                      int.parse(Professorid.text),
                      Professorpassword.text,
                      Professorgraduated.text,
                      int.parse(Professorage.text));
                  print("cccccccccc");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
