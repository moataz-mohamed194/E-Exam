import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'showqueation.dart';
import 'takeexam.dart';

class mainstudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainstudentpage();
  }
}

class mainstudentpage extends State<mainstudent> {
  void initState() {
    super.initState();
    nameofsubject();

    getstudentdatafromSharedPreferences();
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

  Widget thesubjects() {
    return Container(
      child: ListView.builder(
          itemCount: sub_data.length,
          itemBuilder: (context, index) {
            return Text("${index + 1}. ${sub_data[index]['Name']}");
          }),
    );
  }
  /*Widget subject() {
    return ListView.builder(
        itemCount: sub_data.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: <Widget>[Text(sub_data[index]['Name'] ?? "00")],
            ),
          );
        });
  }*/

  String email, nationalId, name, password, CollageId, level, department;

  getstudentdatafromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('ID');
      nationalId = prefs.getString('Nationalid');
      CollageId = prefs.getString('Collageid');
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
          Text("Email: $email"),
          Text("National ID: $nationalId"),
          Text("Name: $name"),
          Text("Collage ID: $CollageId"),
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

  Widget datainmenu() {
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
            /*Divider(),
            ListTile(
              title: Text('profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
            ),*/
            Divider(),
            ListTile(
              title: Text('get exam',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getexam()));
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
                        builder: (context) => showquestionbank()));
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
              child: getthestudentdata(),
              //  flex: 1,
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
        ),
      ),
    ));
  }
}
