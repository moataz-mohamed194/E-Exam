import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentLoginPage();
  }
}

class StudentLoginPage extends State<StudentLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode studentidnode = FocusNode();
  final FocusNode studentpasswordnode = FocusNode();
  TextEditingController studentid;
  TextEditingController studentpassword;
  String studentidsave, studentpasswordsave;
  void initState() {
    super.initState();
    studentid = new TextEditingController();
    studentpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  login() {
    print("ggggggg");
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
                    controller: studentid,
                    focusNode: studentidnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => studentidsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, studentidnode, studentpasswordnode);
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
                    controller: studentpassword,
                    focusNode: studentpasswordnode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => studentpasswordsave = input,
                    onFieldSubmitted: (value) {
                      studentpasswordnode.unfocus();
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
            FlatButton(
              child: Text(
                "Login student",
              ),
              onPressed: () {
                print("ffffffffff");
              },
            ),
          ],
        ),
      ),
    );
  }
}
