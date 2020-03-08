import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class add_department extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_departmentpage();
  }
}

class add_departmentpage extends State<add_department> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode departmentnamenode = FocusNode();
  TextEditingController departmentname;
  String departmentnamesave;

  //controller about combox
  String _ratingController;
  List _professors = [" "];
  List data = new List();
  //to get the element from database and add them to combox
  void nameofprofessor() async {
    database().Leader_of_department().then((result) {
      setState(() {
        data.addAll(result);
      });
      for (int i = 0; i < result.length; i++) {
        _professors.add(data[i]['realName']);
      }
    });
  }

  String _ratingController1;
  List _start = [" ", "level 1", "level 3"];

  void initState() {
    super.initState();
    nameofprofessor();
    departmentname = new TextEditingController();
  }

  //to add the department data to database
  void add_departmentsqlite(String name, String level, String leader) {
    database().add_departmenttosqlite(name, level, leader).whenComplete(() {
      Toast.Toast.show("that department is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          controller: departmentname,
                          focusNode: departmentnamenode,
                          textInputAction: TextInputAction.next,
                          onSaved: (input) => departmentnamesave = input,
                          decoration: InputDecoration(
                            labelText: "Department name",
                            hintText: "Enter department name",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Department name';
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
                            value: _ratingController,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter the time can student join';
                              } else if (value == " ") {
                                return 'Enter the time can student join';
                              } else {
                                return null;
                              }
                            },
                            items: _start
                                .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text('Student can enter from :'),
                            onChanged: (value) {
                              setState(() {
                                _ratingController = value;
                              });
                            },
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          color: Colors.white,
                          child: DropdownButtonFormField<dynamic>(
                            value: _ratingController1,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter Department Leader';
                              } else if (value == " ") {
                                return 'Enter Department Leader';
                              } else {
                                return null;
                              }
                            },
                            items: _professors
                                .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text('Leader of department :'),
                            onChanged: (value) {
                              setState(() {
                                _ratingController1 = value;
                              });
                            },
                          )),
                      Card(
                        color: Colors.blue,
                        child: FlatButton.icon(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              add_departmentsqlite(departmentname.text,
                                  _ratingController1, _ratingController);
                            }
                          },
                          label: Text("ADD Department"),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
