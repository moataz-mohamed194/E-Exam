import 'dart:convert';

//import '../Database/Database_admin.dart';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

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
  List _semesterlist = ["semester 1", "semester 2"];
  List _levellist = ["level 1", "level 2", "level 3", "level 4"];
  List _departmentlist = [];
  List _professorlist = [];
  TextEditingController subjectname;
  String subjectnamesave;
  void initState() {
    super.initState();
    getData();
    subjectname = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;

  List data1 = new List<dynamic>();

  List datadepartment = new List();
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
  List data = new List<dynamic>();
  Future<List> getData() async {
    var url = "http:///app/admin.php";
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
    setState(() {
      subjectname.text = _store.get('Name');
    });
    //return json.decode(response.body);
  }

  Future<void> add_subjectsqlite(String name, String department,
      String professor, var level, String semester, String id) async {
    Map<dynamic, dynamic> f = new Map();
    var url = "http://${_store.ipaddress}/app/admin.php";
    //*if (name != null || semester != null) {

    f["action"] = "updatesubject";
    f["id"] = "$id";
    print("[$professor]");

    if (name != null) {
      f["name"] = "$name";
    }
    if (semester != null) {
      f["semester"] = "$semester";
    }
    if (level != null) {
      f["level"] = "$level";
    }
    if (professor != null) {
      f["professor0000"] = "$professor";
    }
    if (department != null) {
      f["department"] = "$department";
    }

    var response;
    print(f);
    response = await http.post(url, body: f);
    /*.catchError((e) {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqq$e");
    }).whenComplete(() {*/
    String content = response.body;
    print(content);

    Toast.Toast.show("that subject is edited", context,
        duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => get_subject()));
    // });
    // }
    /*if (level != null || professor != null) {
      await http.post(url, body: {
        "action": "updatesubject",
        "professor": professor,
        "id": id,
        "level": level,
        //"level": level
      });
    }*/
    /*await http.post(url, body: {
      "name": name,
      "id": id,
      "semester": semester,
      "level": level
    }).catchError((e) {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqq$e");
    }).whenComplete(() {
      Toast.Toast.show("that subject is edited", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => get_subject()));
    });*/

    /*database()
        .update_subject(name, department, professor, level, semester, id)
        .whenComplete(() {
      Toast.Toast.show("that subject is edited", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => get_subject()));
    });*/
  }

  String i;
  @override
  Widget build(BuildContext context) {
    String semester = _store.get('semester');
    String level = _store.get('level');
    String department = _store.get('department');
    String professor = _store.get('professor');
    // _semesterlist = _store.get('semester');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Edit Subject"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Center(
        child: ListView(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.blue,
                      controller: subjectname,
                      onSaved: (input) => subjectnamesave = input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        labelText: "Current subject name:${_store.get('Name')}",
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
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
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
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
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
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label:
                          Text("Edit", style: TextStyle(color: Colors.white)),
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
