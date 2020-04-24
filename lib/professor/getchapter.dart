import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class GetChapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetChapterPage();
  }
}

class GetChapterPage extends State<GetChapter> {
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
    //   });
  }

  void initState() {
    super.initState();
    nameOfSubject();
    subject();
  }

  List data = new List();
  void subject() async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {"action": "getchapterdata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
  }

  removeChapter(String subjectName, String id) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    await http.post(url, body: {
      "action": "remove_chapter",
      "subjectname": subjectName,
      "id": id
    }).whenComplete(() {
      Toast.Toast.show("that subject is removed", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GetChapter()));
    });
  }

  Widget getQuestion() {
    int i = 0;
    print(data);
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data.isEmpty) {
                return CircularProgressIndicator();
              } else if (data[index]['subjectname'] == subjectValue) {
                i++;
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text("Chapter $i :${data[index]['chaptername']}"),
                      FlatButton(
                        onPressed: () {
                          removeChapter(subjectValue, data[index]['ID']);
                        },
                        child: Text("Remove chapter",
                            style: TextStyle(color: Colors.white)),
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Get Chapter"),
      ),
      backgroundColor: Color(0xFF2E2E2E),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55,
                    top: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                  value: subjectValue,
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
                      subjectValue = value;
                    });
                  },
                )),
            Expanded(child: getQuestion())
          ],
        ),
      ),
    ));
  }
}
