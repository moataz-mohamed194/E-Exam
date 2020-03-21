import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:shared_preferences/shared_preferences.dart';

import 'signupforstudent.dart';

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

  List data = new List();

  login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Databasestudent().checkyouridandpassword(id).then((result) {
      setState(() {
        data.addAll(result);
        // print(result);
      });
      //  if (id.toString() == data[0]['Collageid'].toString()) {
      if (password == data[0]['password']) {
        prefs.setString('ID', "${data[0]['ID']}");
        prefs.setString('Nationalid', "${data[0]['Nationalid']}");
        prefs.setString('Collageid', "${data[0]['Collageid']}");
        prefs.setString('name', "${data[0]['name']}");
        prefs.setString('password', "${data[0]['password']}");
        prefs.setString('level', "${data[0]['level']}");
        prefs.setString('department', "${data[0]['department']}");
        prefs.setString('loginasstudent', "yes");

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/mainstudent', (Route<dynamic> route) => false);
        Toast.Toast.show("Welcome to our app", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        data.clear();
      } else {
        Toast.Toast.show("Check your password and Email", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        data.clear();
      }
      /*} else {
        Toast.Toast.show("Check your password and Email", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        data.clear();
      }*/
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
            Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text(
                  "sgin up ",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => studentsignup()));
                },
              ),
            ),
            FlatButton(
              child: Text(
                "Login student",
              ),
              onPressed: () {
                login(studentid.text, studentpassword.text);
                print("ffffffffff");
                /* Databasestudent()
                    .check_your_id_and_password(studentid.text)
                    .then((result) {
                  setState(() {
                    data.addAll(result);
                    // print(result);
                  });
                  print(data);
                  if (studentid.text.toString() ==
                      data[0]['Collageid'].toString()) {
                    if (studentpassword.text == data[0]['password']) {
                      /*prefs.setString('ID', "${data[0]['ID']}");
          prefs.setString('Nationalid', "${data[0]['Nationalid']}");
          prefs.setString('Email', "${data[0]['Email']}");
          prefs.setString('Password', "${data[0]['Password']}");
          prefs.setString('realName', "${data[0]['realName']}");
          prefs.setString('graduted', "${data[0]['graduted']}");
          prefs.setString('age', "${data[0]['age']}");
          prefs.setString('loginasadmin', "yes");
         */
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //    '/mainforadmin', (Route<dynamic> route) => false);
                      Toast.Toast.show("Welcome to our app", context,
                          duration: Toast.Toast.LENGTH_SHORT,
                          gravity: Toast.Toast.BOTTOM);
                    } else {
                      Toast.Toast.show("Check your password and Email", context,
                          duration: Toast.Toast.LENGTH_SHORT,
                          gravity: Toast.Toast.BOTTOM);
                    }
                  } else {
                    Toast.Toast.show("Check your password and Email", context,
                        duration: Toast.Toast.LENGTH_SHORT,
                        gravity: Toast.Toast.BOTTOM);
                  }
                });*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
