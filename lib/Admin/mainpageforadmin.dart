import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;
import 'add_department.dart';
import 'add_subject.dart';
import 'get_subject.dart';
import 'profile.dart';

class mainadmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return mainadminpage();
  }
}

class mainadminpage extends State<mainadmin> {
  void initState() {
    super.initState();
    get_admin_data_from_SharedPreferences();
    //get_request_data_from_SharedPreferences();
    getData();
  }

  GlobalState _store = GlobalState.instance;

  Map<String, dynamic> chatMap;
  List data = new List<dynamic>();
  Future<List> getData() async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getadmindata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    return json.decode(response.body);
  }

  rejected(String id) async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    await http
        .post(url, body: {"action": "rejected", "id": "$id"}).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => mainadmin()));
    });
  }

  accept(String nationalid, String email, String realName, String password,
      String id, String graduted, String age, String type) async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    await http.post(url, body: {
      "action": "accept",
      "type": type,
      "id": id,
      "Nationalid": nationalid,
      "Email": email,
      "Password": password,
      "realName": realName,
      "graduted": graduted,
      "age": age
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => mainadmin()));
    });
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

  Widget get_the_requests() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("Name:${data[index]['realName']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text("He is:${data[index]['type']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text("Email:${data[index]['Email']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text("National ID:${data[index]['Nationalid']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text("Graduted from:${data[index]['graduted']}"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          accept(
                            data[index]['Nationalid'],
                            data[index]['Email'],
                            data[index]['realName'],
                            data[index]['Password'],
                            data[index]['ID'],
                            data[index]['graduted'],
                            data[index]['age'],
                            data[index]['type'],
                          );
                        },
                        icon: Icon(Icons.check),
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          rejected(data[index]['ID']);
                        },
                        icon: Icon(Icons.clear),
                        color: Colors.blue,
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasadmin', "no");
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/chooselogin', (Route<dynamic> route) => false);
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
          Text("Mr: $name"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2e2e2e),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: datainmenu(),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add department',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_department()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add subject',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_subject()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('edit subject',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => get_subject()));
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
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("E-exam"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            /* Align(
              alignment: Alignment(0, -0.9),
              child: Container(
                width: 35,
                height: 110,
                color: Colors.blue,
              ),
            ),*/
            Expanded(
              child: get_the_requests(),
            ),
            //   get_the_admin_data(),
          ],
        )),
      ),
    );
  }
}
