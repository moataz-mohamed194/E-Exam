import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String email, nationalid, password, realName, graduted, age;
  GlobalState _store = GlobalState.instance;

  void initState() {
    super.initState();
    nameofsubject();

    get_professor_data_from_SharedPreferences();
  }

  List sub = [];

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipaddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      sub_data = json.decode(content);
    });

    for (int i = 0; i < sub_data.length; i++) {
      sub.add(sub_data[i]['Name']);
    }
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
          Expanded(
              child: ListView.builder(
                  itemCount: sub.length,
                  itemBuilder: (context, index) {
                    return Text(sub[index]);
                  }))
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
              child: get_the_professor_data(),
              flex: 1,
            ),
          ],
        ),
      ),
    ));
  }
}
