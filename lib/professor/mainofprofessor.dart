import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'add_queation.dart';

class mainprofessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainprofessorpage();
  }
}

class mainprofessorpage extends State<mainprofessor> {
  String q, w, e, r, t, y;

  void initState() {
    super.initState();
    hh();
  }

  Future hh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      q = prefs.getString('Email');
      w = prefs.getString('Nationalid');
      e = prefs.getString('Password');
      r = prefs.getString('realName');
      t = prefs.getString('graduted');
      y = prefs.getString('age');
    });
  }

  Widget oo() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("$q"),
          Text("$w"),
          Text("$e"),
          Text("$r"),
          Text("$t"),
          Text("$y"),
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
            oo(),
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
