import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class AddChapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddChapterPage();
  }
}

class AddChapterPage extends State<AddChapter> {
  String subjectValue;
  List sub = [];
  GlobalState _store = GlobalState.instance;

  List subData = new List();
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });

    for (int i = 0; i < subData.length; i++) {
      sub.add(subData[i]['Name']);
    }
    //  });
  }

  final _formKey = GlobalKey<FormState>();
  final FocusNode chapterNameNode = FocusNode();
  TextEditingController controllerChapterName;
  String chapterNameSave;
  void initState() {
    super.initState();
    nameOfSubject();
    controllerChapterName = new TextEditingController();
  }

  var d;
  addChapter(String subjectName, String chapterName) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    d = await http.post(url, body: {
      "action": "add_chapter",
      "subjectname": subjectName,
      "chaptername": chapterName
    }).catchError((e) {
      print("00000000000000000000000$e");
    }).whenComplete(() {
      Toast.Toast.show("that chapter is added", context,
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
          title: Text("Add Chapter"),
        ),
        backgroundColor: Color(0xff2e2e2e),
        body: Container(
            alignment: Alignment.center,
            child: Form(
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
                      controller: controllerChapterName,
                      focusNode: chapterNameNode,
                      textInputAction: TextInputAction.next,
                      onSaved: (input) => chapterNameSave = input,
                      decoration: InputDecoration(
                        labelText: "chapter name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Enter chapter name",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter chapter name';
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
                      value: subjectValue,
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
                          subjectValue = value;
                        });
                      },
                    ),
                  ),
                  Card(
                      color: Colors.blue,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addChapter(
                                  controllerChapterName.text, subjectValue);
                            }
                          },
                          child: Text("add chapter",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
