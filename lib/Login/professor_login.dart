import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'signupforprofessor.dart';

class ProfessorLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfessorLoginPage();
  }
}

class ProfessorLoginPage extends State<ProfessorLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Professoridnode = FocusNode();
  final FocusNode Professorpasswordnode = FocusNode();
  TextEditingController Professorid;
  TextEditingController Professorpassword;
  String Professoridsave, Professorpasswordsave;
  void initState() {
    super.initState();
    Professorid = new TextEditingController();
    Professorpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  List data = new List();

  login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    database_professor()
        .check_your_email_and_password('Professor', id)
        .then((result) {
      setState(() {
        data.addAll(result);
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
          Toast.Toast.show("Check your password and Email", context,
              duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        }
      });
    });
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
                    keyboardType: TextInputType.text,
                    controller: Professorid,
                    focusNode: Professoridnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Professoridsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Professoridnode, Professorpasswordnode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your Email",
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Professorpassword,
                    focusNode: Professorpasswordnode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Professorpasswordsave = input,
                    onFieldSubmitted: (value) {
                      Professorpasswordnode.unfocus();
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
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
                          builder: (context) => Professorsignup()));
                },
              ),
            ),
            FlatButton(
              child: Text(
                "Login Professor",
              ),
              onPressed: () {
                login(Professorid.text, Professorpassword.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}