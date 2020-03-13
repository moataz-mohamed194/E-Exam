import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

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
  List data = new List();
  void subject() async {
    database().get_subject().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    subject();
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
                  child: Text(
                      "Professor will teach subject :${data[index]['professor']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                      "Subject be to department :${data[index]['department']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("in :${data[index]['level']}"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("in :${data[index]['semester']}"),
                ),
                Card(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  color: Colors.blue,
                  child: FlatButton.icon(
                    icon: Icon(Icons.edit),
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
                    label: Text("Edit"),
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
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        child: subject_data(),
      ),
    ));
  }
}
