import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class add_chapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_chapterpage();
  }
}

class add_chapterpage extends State<add_chapter> {
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
  final FocusNode chapternamenode = FocusNode();
  TextEditingController controllerchaptername;
  String chapternamesave;
  void initState() {
    super.initState();
    nameofsubject();
    controllerchaptername = new TextEditingController();
  }

  addchapter(String subjectname, String chaptername) {
    database_professor()
        .add_chapter_tosqlite(chaptername, subjectname)
        .whenComplete(() {
      Toast.Toast.show("that chapter is added", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: controllerchaptername,
                focusNode: chapternamenode,
                textInputAction: TextInputAction.next,
                onSaved: (input) => chapternamesave = input,
                decoration: InputDecoration(
                  labelText: "chapter name",
                  hintText: "Enter chapter name",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter chapter  name';
                  } else {
                    return null;
                  }
                },
              ),
              DropdownButtonFormField<dynamic>(
                value: subjectvalue,
                validator: (value) {
                  if (value == null) {
                    return 'Enter the subject';
                  } else if (value == " ") {
                    return 'Enter the subject';
                  } else {
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
              FlatButton(
                onPressed: () {
                  addchapter(controllerchaptername.text, subjectvalue);
                },
                child: Text("add department"),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
