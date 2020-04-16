import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

import 'edit_subject.dart';

class get_subject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return get_subjectpage();
  }
}

class get_subjectpage extends State<get_subject> {
  GlobalState _store = GlobalState.instance;
  // List data = new List();
  @override
  void initState() {
    super.initState();
    // subject();
    getData();
  }

  List data = new List<dynamic>();
  Future<List> getData() async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getsubject"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });

    return json.decode(response.body);
  }

  Widget subject_data() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("Subject Name :${data[index]['Name']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("Professor :${data[index]['professor']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("Department :${data[index]['department']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("${data[index]['level']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("Semester :${data[index]['semester']}"),
                ),
                Card(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  color: Colors.blue,
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _store.set('Name', data[index]['Name']);
                      _store.set('department', data[index]['department']);
                      _store.set('professor', data[index]['professor']);
                      _store.set('level', data[index]['level']);
                      _store.set('semester', data[index]['semester']);
                      _store.set('ID', data[index]['ID']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit_subject()));
                    },
                    label: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Subjects"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        child: subject_data(),
      ),
    ));
  }
}
