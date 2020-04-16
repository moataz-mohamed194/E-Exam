import 'dart:convert';

import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class add_subject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_subjectpage();
  }
}

class add_subjectpage extends State<add_subject> {
  final _formKey = GlobalKey<FormState>();
  String _semester, _level, _department, _professor;
  List _semesterlist = ["semester 1", "semester 2"];
  List _levellist = ["level 1", "level 2", "level 3", "level 4"];
  List _departmentlist = ["general"];
  List _professorlist = [];
  TextEditingController subjectname;
  String subjectnamesave;

  void initState() {
    super.initState();
    //   nameofdepartment();
//    nameofprofessor();
//    nameofdepartment();

    getData();

    subjectname = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;

  List data = new List<dynamic>();
  Future<List> getData() async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getprofessordata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    for (int i = 0; i < data.length; i++) {
      setState(() {
        _professorlist.add(data[i]['realName']);
      });
    }
    return json.decode(response.body);
  }

  List data1 = new List<dynamic>();

  List datadepartment = new List();
  //get the professor from database and add them to
  void nameofdepartment(String studentlevel) async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    final response =
        await http.post(url, body: {"action": "getdepartmentdata"});
    String content = response.body;
    setState(() {
      data1 = json.decode(content);
    });
    for (int i = 0; i < data1.length; i++) {
      setState(() {
        datadepartment.add(data1[i]['Name'].toString());
      });
    }
    print(studentlevel);
    _departmentlist.add("general");
    for (int i = 0; i < data1.length; i++) {
      if (studentlevel == "level 3" || studentlevel == "level 4") {
        if (!_departmentlist.contains(data1[i]['Name'])) {
          _departmentlist.add(data1[i]['Name'].toString());
        }
      } else if (studentlevel == "level 1" || studentlevel == "level 2") {
        if (!_departmentlist.contains(data1[i]['Name'])) {
          if (data1[i]['whenstart'] == "level 1" ||
              data1[i]['whenstart'] == "level 2") {
            _departmentlist.add(data1[i]['Name'].toString());
          }
        }
      }
    }
    // });
  }

  List dataprofessor = new List();
  //get the professor from database and add them to
  Future<void> add_subjectsqlite(String name, String department,
      String professor, String level, String semester) async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    await http.post(url, body: {
      "action": "addsubject",
      "name": name,
      "department": department,
      "professor": professor,
      "level": level,
      "semester": semester,
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Toast.Toast.show("that subject is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Add Subject"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          controller: subjectname,
                          onSaved: (input) => subjectnamesave = input,
                          decoration: InputDecoration(
                            labelText: "subject name",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            hintText: "Enter subject name",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter subject name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButtonFormField<dynamic>(
                          value: _semester,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter semester';
                            } else if (value == " ") {
                              return 'Enter semester';
                            } else {
                              return null;
                            }
                          },
                          items: _semesterlist
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Semester :'),
                          onChanged: (value) {
                            setState(() {
                              _semester = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButtonFormField<dynamic>(
                          value: _level,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter level';
                            } else if (value == " ") {
                              return 'Enter level';
                            } else {
                              return null;
                            }
                          },
                          items: _levellist
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('level :'),
                          onChanged: (value) {
                            setState(() {
                              nameofdepartment(value);

                              _departmentlist.clear();
                              _level = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButtonFormField<dynamic>(
                          value: _department,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter Department';
                            } else if (value == " ") {
                              return 'Enter Department';
                            } else {
                              return null;
                            }
                          },
                          items: _departmentlist
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Department :'),
                          onChanged: (value) {
                            setState(() {
                              _department = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButtonFormField<dynamic>(
                          value: _professor,
                          validator: (value) {
                            if (value == null) {
                              return 'Enter Professor';
                            } else if (value == " ") {
                              return 'Enter Professor';
                            } else {
                              return null;
                            }
                          },
                          items: _professorlist
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Professor :'),
                          onChanged: (value) {
                            setState(() {
                              _professor = value;
                            });
                          },
                        ),
                      ),
                      Card(
                        color: Colors.blue,
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              add_subjectsqlite(subjectname.text, _department,
                                  _professor, _level, _semester);
                            }
                          },
                          label: Text("ADD Subject",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
