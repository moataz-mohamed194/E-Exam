import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:shared_preferences/shared_preferences.dart';
import 'signupforstudent.dart';

class StudentLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 40),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: studentid,
                              focusNode: studentidnode,
                              textInputAction: TextInputAction.next,
                              onSaved: (input) => studentidsave = input,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context, studentidnode,
                                    studentpasswordnode);
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
                                  bottom:
                                      MediaQuery.of(context).size.height / 40),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: studentpassword,
                                focusNode: studentpasswordnode,
                                textInputAction: TextInputAction.done,
                                onSaved: (input) => studentpasswordsave = input,
                                onFieldSubmitted: (value) {
                                  studentpasswordnode.unfocus();
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
                            child: Text("Login as student",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              login(studentid.text, studentpassword.text);
                              print("ffffffffff");
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
                                  builder: (context) => studentsignup()));
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
