import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'profile.dart';
import 'showqueation.dart';
import 'takeexam.dart';

class mainstudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainstudentpage();
  }
}

class mainstudentpage extends State<mainstudent> {
  void initState() {
    super.initState();
    getstudentdatafromSharedPreferences();
  }

  String email, nationalid, name, password, graduted, age;

  Future getstudentdatafromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('ID');
      nationalid = prefs.getString('Nationalid');
      password = prefs.getString('Collageid');
      name = prefs.getString('password');
      graduted = prefs.getString('name');
      age = prefs.getString('level');
      age = prefs.getString('department');
    });
  }

  Widget getthestudentdata() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("$email"),
          Text("$nationalid"),
          Text("$name"),
          Text("$graduted"),
          Text("$age"),
        ],
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasstudent', "no");
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/chooselogin', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            getthestudentdata(),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile()));
                },
                color: Colors.blue,
                child: Text("profile")),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => showquestionbank()));
                },
                color: Colors.blue,
                child: Text("Bank")),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => getexam()));
                },
                color: Colors.blue,
                child: Text("get exam")),
            FlatButton(
                onPressed: () {
                  logout();
                },
                color: Colors.blue,
                child: Text("log out"))
          ],
        ),
      ),
    ));
  }
}
