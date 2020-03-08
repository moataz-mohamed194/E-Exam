import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

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
  List _semesterlist = [" ", "semester 1", "semester 2"];
  List _levellist = [" ", "level 1", "level 2", "level 3", "level 4"];
  List _departmentlist = [" "];
  List _professorlist = [" "];
  TextEditingController subjectname;
  String subjectnamesave;

  void initState() {
    super.initState();
    nameofdepartment();
    nameofprofessor();
    subjectname = new TextEditingController();
  }

  List datadepartment = new List();
  //get the professor from database and add them to
  void nameofdepartment() async {
    database().name_of_department().then((result) {
      setState(() {
        datadepartment.addAll(result);
      });
      for (int i = 0; i < result.length; i++) {
        _departmentlist.add(datadepartment[i]['Name']);
      }
    });
  }

  List dataprofessor = new List();
  //get the professor from database and add them to
  void nameofprofessor() async {
    database().Leader_of_department().then((result) {
      setState(() {
        dataprofessor.addAll(result);
      });
      for (int i = 0; i < result.length; i++) {
        _professorlist.add(dataprofessor[i]['realName']);
      }
    });
  }

  void add_subjectsqlite(String name, String department, String professor,
      String level, String semester) {
    database()
        .add_subjecttosqlite(name, department, professor, level, semester)
        .whenComplete(() {
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
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          controller: subjectname,
                          onSaved: (input) => subjectnamesave = input,
                          decoration: InputDecoration(
                            labelText: "subject name",
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
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
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
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
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
                              _level = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
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
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
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
                          icon: Icon(Icons.save),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              add_subjectsqlite(subjectname.text, _department,
                                  _professor, _level, _semester);
                            }
                          },
                          label: Text("ADD Subject"),
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
