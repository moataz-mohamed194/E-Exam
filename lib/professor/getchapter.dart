import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class get_chapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return get_chapterpage();
  }
}

class get_chapterpage extends State<get_chapter> {
  String subjectvalue;
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
      for (int i = 0; i < result.length; i++) {
        sub.add(sub_data[i]['Name']);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    nameofsubject();
    subject();
  }

  List data = new List();
  void subject() async {
    database_professor().getchapter().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  removechapter(String subjectname, int id) {
    database_professor()
        .remove_chapter_tosqlite(subjectname, id)
        .whenComplete(() {
      Toast.Toast.show("that subject is removed", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => get_chapter()));
    });
  }

  Widget get_queation() {
    int i = 0;
    return Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index]['subjectname'] == subjectvalue) {
                i++;
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text("Chapter $i :${data[index]['subjectname']}"),
                      Text("Chapter $i :${data[index]['chaptername']}"),
                      FlatButton(
                        onPressed: () {
                          removechapter(subjectvalue, data[index]['ID']);
                        },
                        child: Text("Remove chapter"),
                        color: Colors.blue,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<dynamic>(
              value: subjectvalue,
              validator: (value) {
                if (value == null) {
                  return 'Enter the subject';
                } else if (value == " ") {
                  return 'Enter the subject';
                } else {
                  subject();
                  return null;
                }
              },
              items: sub
                  .map((label) => DropdownMenuItem(
                        child: Text(label.toString()),
                        value: label,
                      ))
                  .toList(),
              hint: Text('Subject :'),
              onChanged: (value) {
                setState(() {
                  subjectvalue = value;
                });
              },
            ),
            Expanded(child: get_queation())
          ],
        ),
      ),
    ));
  }
}
