import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'add_department.dart';
import 'add_subject.dart';
import 'request.dart';

class mainadmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainadminpage();
  }
}

class mainadminpage extends State<mainadmin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => request()));
              },
              child: Text("request"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_department()));
              },
              child: Text("add department"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_subject()));
              },
              child: Text("add subject"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_subject()));
              },
              child: Text("edit subject"),
              color: Colors.blue,
            ),
          ],
        )),
      ),
    );
  }
}
