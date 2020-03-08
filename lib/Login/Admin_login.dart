import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:shared_preferences/shared_preferences.dart';
import 'signupadmin.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminLoginPage();
  }
}

class AdminLoginPage extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode adminidnode = FocusNode();
  final FocusNode adminpasswordnode = FocusNode();
  TextEditingController adminid;
  TextEditingController adminpassword;
  String adminidsave, adminpasswordsave;
  void initState() {
    super.initState();
    adminid = new TextEditingController();
    adminpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  List data = new List();

  login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    database().check_your_email_and_password('Admin', id).then((result) {
      setState(() {
        data.addAll(result);
        print(result);
        if (password == data[0]['Password']) {
          prefs.setString('ID', "${data[0]['ID']}");
          prefs.setString('Nationalid', "${data[0]['Nationalid']}");
          prefs.setString('Email', "${data[0]['Email']}");
          prefs.setString('Password', "${data[0]['Password']}");
          prefs.setString('realName', "${data[0]['realName']}");
          prefs.setString('graduted', "${data[0]['graduted']}");
          prefs.setString('age', "${data[0]['age']}");
          prefs.setString('loginasadmin', "yes");
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainforadmin', (Route<dynamic> route) => false);
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
                    controller: adminid,
                    focusNode: adminidnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => adminidsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, adminidnode, adminpasswordnode);
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
                    controller: adminpassword,
                    focusNode: adminpasswordnode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => adminpasswordsave = input,
                    onFieldSubmitted: (value) {
                      adminpasswordnode.unfocus();
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
                      MaterialPageRoute(builder: (context) => Adminsignup()));
                },
              ),
            ),
            FlatButton(
              child: Text(
                "Login admin",
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  login(adminid.text, adminpassword.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
