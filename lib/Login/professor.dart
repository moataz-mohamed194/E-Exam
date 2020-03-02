import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  login() {}
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
                print("cccccccccc");
              },
            ),
          ],
        ),
      ),
    );
  }
}
