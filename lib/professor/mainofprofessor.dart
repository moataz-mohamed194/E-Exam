import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_queation.dart';
import 'addchapter.dart';
import 'addexam.dart';
import 'getchapter.dart';
import 'showqueation.dart';

class mainprofessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return mainprofessorpage();
  }
}

class mainprofessorpage extends State<mainprofessor> {
  String email, nationalid, password, realName, graduted, age;

  void initState() {
    super.initState();
    nameofsubject();

    get_professor_data_from_SharedPreferences();
  }

  List sub = [];

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
    return Card(
      child: Column(
        children: <Widget>[
          Text("Name: $realName"),
          Text("Email: $email"),
          Text("National id: $nationalid"),
          Text("Graduted: $graduted"),
          Text("Age: $age"),
        ],
      ),
    );
  }

  Widget datainmenu() {
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

  Widget thesubjects() {
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

  List subdata = new List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                title: datainmenu(),
              ),
              Divider(),
              ListTile(
                title: Text('add chapter',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_chapter()));
                },
              ),
              /*Divider(),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile()));
                },
              ),*/
              Divider(),
              ListTile(
                title: Text('get chapter',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => get_chapter()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add qustion',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_question()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('show qustion',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => show_question()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add exam',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addexam()));
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
              child: get_the_professor_data(),
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
                    child: thesubjects())
              ],
            ))
          ],
        )),
      ),
    );
  }
}
