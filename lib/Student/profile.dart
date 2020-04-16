import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  GlobalState _store = GlobalState.instance;

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipaddress}/app/student.php";
    final response = await http.post(url, body: {
      "action": "getstudentsubject",
      "level": "${prefs.getString('level')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      sub_data = json.decode(content);
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
