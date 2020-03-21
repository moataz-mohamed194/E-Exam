import 'package:exam/Database/Database_professor.dart';
import 'package:exam/Database/Database_student.dart';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profilepage();
  }
}

class profilepage extends State<profile> {
  void initState() {
    super.initState();
    getstudentdatafromSharedPreferences();
    nameofsubject();
  }

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Databasestudent()
        .getstudentsubject(prefs.getString('level'))
        .then((result) {
      setState(() {
        sub_data.addAll(result);
      });
    });
  }

  Widget ii() {
    return Container(
        child: ListView.builder(
            itemCount: sub_data.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[Text(sub_data[index]['Name'])],
                ),
              );
            }));
  }

  String iD, nationalid, collageid, password, name, level, department;

  Future getstudentdatafromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iD = prefs.getString('ID');
      nationalid = prefs.getString('Nationalid');
      collageid = prefs.getString('Collageid');
      password = prefs.getString('password');
      name = prefs.getString('name');
      level = prefs.getString('level');
      department = prefs.getString('department');
    });
  }

  Widget getthestudentdata() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("$iD"),
          Text("$nationalid"),
          Text("$name"),
          Text("$collageid"),
          Text("$level"),
          Text("$department"),
          Text("$password"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: getthestudentdata(),
              flex: 1,
            ),
            Expanded(
              child: ii(),
              flex: 1,
            )
          ],
        ),
      ),
    ));
  }
}
