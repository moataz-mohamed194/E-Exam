import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

import 'add_department.dart';
import 'add_subject.dart';
import 'get_subject.dart';

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
    get_request_data_from_SharedPreferences();
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

  List data = new List();
  void get_request_data_from_SharedPreferences() async {
    database().get_request().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
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
                          database()
                              .accept(
                            data[index]['Nationalid'],
                            data[index]['Email'],
                            data[index]['realName'],
                            data[index]['Password'],
                            data[index]['ID'],
                            data[index]['graduted'],
                            data[index]['age'],
                            data[index]['type'],
                          )
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mainadmin()));
                          });
                        },
                        icon: Icon(Icons.check),
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          database().remove(data[index]['ID']).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mainadmin()));
                          });
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
                title: get_the_admin_data(),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('add department'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_department()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('add subject'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_subject()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('edit subject'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => get_subject()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('log out'),
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
            Expanded(
              child: get_the_requests(),
            ),
//            get_the_admin_data(),
          ],
        )),
      ),
    );
  }
}
