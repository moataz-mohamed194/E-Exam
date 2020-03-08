import '../Database/Database_admin.dart';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;

import 'get_subject.dart';

class edit_subject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return edit_subjectPage();
  }
}

class edit_subjectPage extends State<edit_subject> {
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
      String level, String semester, String id) {
    database()
        .update_subject(name, department, professor, level, semester, id)
        .whenComplete(() {
      Toast.Toast.show("that subject is edited", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => get_subject()));
    });
  }

  GlobalState _store = GlobalState.instance;
  String i;
  @override
  Widget build(BuildContext context) {
    subjectname.text = _store.get('Name');
    String semester = _store.get('semester');
    String level = _store.get('level');
    String department = _store.get('department');
    String professor = _store.get('professor');
    // _semesterlist = _store.get('semester');
    return Scaffold(
      backgroundColor: Color(0xff2e2e2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.blue,
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
                      decoration: InputDecoration(
                        labelText: "Current semester :$semester",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return 'Enter semester';
                        } else {
                          _store.set('semester', _semester);

                          return null;
                        }
                      },
                      items: _semesterlist
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
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
                      decoration: InputDecoration(
                        labelText: "Current level :$level",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return 'Enter level';
                        } else {
                          _store.set('level', _level);

                          return null;
                        }
                      },
                      items: _levellist
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
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
                      decoration: InputDecoration(
                        labelText: "Current department :$department",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return 'Enter Department';
                        } else {
                          _store.set('department', _department);

                          return null;
                        }
                      },
                      items: _departmentlist
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
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
                      decoration: InputDecoration(
                        labelText: "Current professor :$professor",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return 'Enter Professor';
                        } else {
                          _store.set('professor', _professor);

                          return null;
                        }
                      },
                      items: _professorlist
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
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
                      label: Text(
                        "ADD Edit",
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          add_subjectsqlite(
                              subjectname.text,
                              _store.get('department'),
                              _store.get('professor'),
                              _store.get('level'),
                              _store.get('semester'),
                              _store.get('ID').toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
