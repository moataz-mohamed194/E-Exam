import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;

class studentsignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return studentsignupPage();
  }
}

class studentsignupPage extends State<studentsignup> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Studentidnode = FocusNode();
  final FocusNode Studentidcardnode = FocusNode();
  final FocusNode Studentnamenode = FocusNode();
  final FocusNode Studentpasswordnode = FocusNode();
  TextEditingController Studentid;
  TextEditingController Studentidcard;
  TextEditingController Studentname;
  TextEditingController Studentpassword;
  String Studentidsave, Studentidcardsave, Studentnamesave, Studentpasswordsave;
  String levelvalue;
  List level = ["level 1", "level 2", "level 3", "level 4"];
  String departmentvalue;
  List department = ["general"];
  List departmentdata = new List();
  void nameofdepartment(String studentlevel) async {
    department.add("general");

    Databasestudent().getdepartment().then((result) {
      setState(() {
        departmentdata.addAll(result);
      });
      for (int i = 0; i < result.length; i++) {
        if (studentlevel == "level 3" || studentlevel == "level 4") {
          if (!department.contains(departmentdata[i]['Name'])) {
            department.add(departmentdata[i]['Name']);
          }
        } else if (studentlevel == "level 1" || studentlevel == "level 2") {
          if (!department.contains(departmentdata[i]['Name'])) {
            if (departmentdata[i]['leader'] == "level 1" ||
                departmentdata[i]['leader'] == "level 2") {
              department.add(departmentdata[i]['Name']);
            }
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Studentid = new TextEditingController();
    Studentidcard = new TextEditingController();
    Studentname = new TextEditingController();
    Studentpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  signup(String nationalid, String collageid, String name, String password,
      String level, String department) {
    Databasestudent()
        .signupstudent(nationalid, collageid, name, password, level, department)
        .whenComplete(() {
      Navigator.pop(context);
      Toast.Toast.show("your data is added", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xFF2E2E2E),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset('img/logo.png'),
                      flex: 1,
                    ),
                    Expanded(
                        flex: 2,
                        child: Form(
                            key: _formKey,
                            child: ListView(
                              padding: EdgeInsets.only(top: 0),
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: Studentid,
                                    focusNode: Studentidnode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) => Studentidsave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context, Studentidnode,
                                          Studentidcardnode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: "Your National ID",
                                      hintText: "Enter your National ID",
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Your National ID';
                                      } else if (value.length < 6) {
                                        return 'Your ID must be longer than 6 numbers';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: Studentidcard,
                                    focusNode: Studentidcardnode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) =>
                                        Studentidcardsave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          Studentidcardnode, Studentnamenode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: "Your id in card",
                                      hintText: "Enter your id in card",
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Your id in card';
                                      } else if (value.length < 6) {
                                        return 'Your ID must be longer than 6 numbers';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: Studentname,
                                    focusNode: Studentnamenode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) => Studentnamesave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          Studentnamenode, Studentpasswordnode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: "Your Name",
                                      hintText: "Enter your Name",
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Your Name';
                                      } else if (value.length < 6) {
                                        return 'Your ID must be longer than 6 numbers';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: Studentpassword,
                                    focusNode: Studentpasswordnode,
                                    textInputAction: TextInputAction.done,
                                    onSaved: (input) =>
                                        Studentpasswordsave = input,
                                    onFieldSubmitted: (term) {
                                      Studentpasswordnode.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: "Your Passowrd",
                                      hintText: "Enter your Passowrd",
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Your Passowrd';
                                      } else if (value.length < 6) {
                                        return 'Your ID must be longer than 6 numbers';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: DropdownButtonFormField<dynamic>(
                                    value: levelvalue,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Enter your level';
                                      } else if (value == " ") {
                                        return 'Enter your level';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: level
                                        .map((label) => DropdownMenuItem(
                                              child: Text(label.toString()),
                                              value: label,
                                            ))
                                        .toList(),
                                    hint: Text('Level :'),
                                    onChanged: (value) {
                                      department.clear();
                                      setState(() {
                                        nameofdepartment(value);
                                        levelvalue = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: DropdownButtonFormField<dynamic>(
                                    value: departmentvalue,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Enter the subject';
                                      } else if (value == " ") {
                                        return 'Enter the subject';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: department
                                        .map((label) => DropdownMenuItem(
                                              child: Text(label.toString()),
                                              value: label,
                                            ))
                                        .toList(),
                                    hint: Text('Subject :'),
                                    onChanged: (value) {
                                      setState(() {
                                        departmentvalue = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              40),
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    child: Text(
                                      "login ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Card(
                                    color: Colors.blue,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: FlatButton(
                                        child: Text("sign up Student",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            print("cccccccccc");
                                            signup(
                                                Studentid.text,
                                                Studentidcard.text,
                                                Studentname.text,
                                                Studentpassword.text,
                                                levelvalue,
                                                departmentvalue);
                                          }
                                        },
                                      ),
                                    ))
                              ],
                            )))
                  ])),
        ));
  }
}
