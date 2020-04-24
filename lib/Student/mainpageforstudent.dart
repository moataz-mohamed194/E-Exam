import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chooseexam.dart';
import 'showqueation.dart';

class MainStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainStudentPage();
  }
}

class MainStudentPage extends State<MainStudent> {
  void initState() {
    super.initState();
    nameOfSubject();

    getStudentDataFromSharedPreferences();
  }

  GlobalState _store = GlobalState.instance;

  List subData = new List();
  //get the name of his subjects
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http.post(url, body: {
      "action": "getstudentsubject",
      "level": "${prefs.getString('level')}",
      "department": "${prefs.getString('department')}",
    });
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });
  }

  Widget theSubjects() {
    return Container(
      child: ListView.builder(
          itemCount: subData.length,
          itemBuilder: (context, index) {
            return Text("${index + 1}. ${subData[index]['Name']}");
          }),
    );
  }

  String email, nationalId, name, password, collageId, level, department;

  getStudentDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('ID');
      nationalId = prefs.getString('Nationalid');
      collageId = prefs.getString('Collageid');
      password = prefs.getString('password');
      name = prefs.getString('name');
      level = prefs.getString('level');
      department = prefs.getString('department');
    });
  }

  Widget getTheStudentData() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("Email: $email"),
          Text("National ID: $nationalId"),
          Text("Name: $name"),
          Text("Collage ID: $collageId"),
          Text("Level: $level"),
          Text("Password: $password"),
          Text("Department: $department"),
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

  Widget dataInMenu() {
    return Column(
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
        Text(name ?? ""),
      ],
    );
  }

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
              title: Text('get exam',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChooseExam()));
              },
            ),
            Divider(),
            ListTile(
              title:
                  Text('Bank', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowQuestionBank()));
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
                children: <Widget>[Text("Welcome to our app :\n $name")],
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: getTheStudentData(),
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
        ),
      ),
    ));
  }
}
