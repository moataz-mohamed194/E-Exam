import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'add_queation.dart';
import 'addchapter.dart';
import 'addexam.dart';
import 'getchapter.dart';
import 'profile.dart';
import 'showqueation.dart';

class mainprofessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainprofessorpage();
  }
}

class mainprofessorpage extends State<mainprofessor> {
  String email, nationalid, password, realName, graduted, age;

  void initState() {
    super.initState();
    get_professor_data_from_SharedPreferences();
  }

  Future get_professor_data_from_SharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('Email');
      nationalid = prefs.getString('Nationalid');
      password = prefs.getString('Password');
      realName = prefs.getString('realName');
      graduted = prefs.getString('graduted');
      age = prefs.getString('age');
    });
  }

  Widget get_the_professor_data() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("$email"),
          Text("$nationalid"),
          Text("$password"),
          Text("$realName"),
          Text("$graduted"),
          Text("$age"),
        ],
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasprofessor', "no");
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
            get_the_professor_data(),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addexam()));
              },
              child: Text("add exam"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
              child: Text("profile"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_chapter()));
              },
              child: Text("add chapter"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => get_chapter()));
              },
              child: Text("get chapter"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_question()));
              },
              child: Text("add qustion"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => show_question()));
              },
              child: Text("show qustion"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                logout();
              },
              child: Text("log out"),
              color: Colors.blue,
            ),
          ],
        )),
      ),
    );
  }
}
