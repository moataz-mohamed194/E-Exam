import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'edit_subject.dart';

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
    get_admin_data_from_SharedPreferences();
  }

  String email, nationalid, name, password, graduted, age;

  Future get_admin_data_from_SharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('Email');
      nationalid = prefs.getString('Nationalid');
      password = prefs.getString('Password');
      name = prefs.getString('realName');
      graduted = prefs.getString('graduted');
      age = prefs.getString('age');
    });
  }

  Widget get_the_admin_data() {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[get_the_admin_data()],
        ),
      ),
    ));
  }
}
