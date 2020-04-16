import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

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

  String _ratingController;
  List _professors = [];
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
        _professors.add(data[i]['realName']);
      });
    }
    return json.decode(response.body);
  }

  String _ratingController1;
  List _start = ["level 1", "level 3"];

  void initState() {
    super.initState();
    //  nameofprofessor();
    getData();
    departmentname = new TextEditingController();
  }

  //to add the department data to database
  void add_departmentsql(String name, String level, String leader) async {
    var url = "http://${_store.ipaddress}/app/admin.php";
    await http.post(url, body: {
      "action": "add_department",
      "name": name,
      "whenstart": level,
      "leader": leader
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Toast.Toast.show("that department is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("Add Department"),
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
                          controller: departmentname,
                          focusNode: departmentnamenode,
                          textInputAction: TextInputAction.next,
                          onSaved: (input) => departmentnamesave = input,
                          decoration: InputDecoration(
                            labelText: "Department name",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
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
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
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
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
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
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              add_departmentsql(
                                departmentname.text,
                                _ratingController,
                                _ratingController1,
                              );
                            }
                          },
                          label: Text("ADD Department",
                              style: TextStyle(color: Colors.white)),
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
