import 'package:exam/Database/Database_professor.dart';
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
  String email, nationalid, password, realName, graduted, age;

  void initState() {
    super.initState();
    nameofsubject();

    get_professor_data_from_SharedPreferences();
  }

  List sub = [" "];

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    database_professor()
        .get_the_subject(prefs.getString('realName'))
        .then((result) {
      setState(() {
        sub_data.addAll(result);
      });
      print(sub_data);
      for (int i = 0; i < result.length; i++) {
        sub.add(sub_data[i]['Name']);
      }
    });
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

/*  Widget oo() {
    return ;
  }
*/
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
            /*   Expanded(
              child: oo(),
              flex: 1,
            )*/
          ],
        ),
      ),
    ));
  }
}
