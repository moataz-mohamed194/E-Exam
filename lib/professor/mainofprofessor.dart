import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:exam/professor/addchapter.dart';
import 'package:exam/professor/getchapter.dart';
import 'package:exam/professor/showqueation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_queation.dart';
import 'addexam.dart';

class MainProfessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainProfessorPage();
  }
}

class MainProfessorPage extends State<MainProfessor> {
  String email, nationalId, password, realName, graduated, age;

  void initState() {
    super.initState();
    nameOfSubject();

    getProfessorDataFromSharedPreferences();
  }

  List sub = [];
  GlobalState _store = GlobalState.instance;

  List subData = new List();
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });

    for (int i = 0; i < subData.length; i++) {
      sub.add(subData[i]['Name']);
    }
  }

  Future getProfessorDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('Email');
      nationalId = prefs.getString('Nationalid');
      password = prefs.getString('Password');
      realName = prefs.getString('realName');
      graduated = prefs.getString('graduted');
      age = prefs.getString('age');
    });
  }

  Widget getTheProfessorData() {
    return Card(
      child: Column(
        children: <Widget>[
          Text("Name: $realName"),
          Text("Email: $email"),
          Text("National id: $nationalId"),
          Text("Graduted: $graduated"),
          Text("Age: $age"),
        ],
      ),
    );
  }

  Widget dataInMenu() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: CircleAvatar(
              radius: 45.0,
              backgroundImage: AssetImage(
                'img/professor.png',
              ),
            ),
          ),
          Text("PRO: $realName"),
        ],
      ),
    );
  }

  Widget theSubjects() {
    return Container(
      child: ListView.builder(
          itemCount: sub.length,
          itemBuilder: (context, index) {
            return Text("${index + 1}. ${sub[index]}");
          }),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasprofessor', "no");
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/chooselogin', (Route<dynamic> route) => false);
  }

  List subData1 = new List();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("E-exam"),
        ),
        backgroundColor: Color(0xff2e2e2e),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: dataInMenu(),
              ),
              Divider(),
              ListTile(
                title: Text('add chapter',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddChapter()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('get chapter',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetChapter()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add qustion',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddQuestion()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('show qustion',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowQuestion()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add exam',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddExam()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('log out',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  logout();
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Card(
                child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Wrap(
                children: <Widget>[Text("Welcome professor :\n $realName")],
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: getTheProfessorData(),
            ),
            Card(
                child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("the subjects you teach :"),
                ),
                Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2,
                    child: theSubjects())
              ],
            ))
          ],
        )),
      ),
    );
  }
}
