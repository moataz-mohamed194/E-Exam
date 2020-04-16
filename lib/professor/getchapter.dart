import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class get_chapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return get_chapterpage();
  }
}

class get_chapterpage extends State<get_chapter> {
  String subjectvalue;
  List sub = [];
  GlobalState _store = GlobalState.instance;

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /*database_professor()
        .get_the_subject(prefs.getString('realName'))
        .then((result) {
      setState(() {
        sub_data.addAll(result);
      });*/
    var url = "http://${_store.ipaddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      sub_data = json.decode(content);
    });
    for (int i = 0; i < sub_data.length; i++) {
      sub.add(sub_data[i]['Name']);
    }
    //   });
  }

  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    nameofsubject();
    subject();
  }

  List data = new List();
  void subject() async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    final response = await http.post(url, body: {"action": "getchapterdata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });

    /*database_professor().getchapter().then((result) {
      setState(() {
        data.addAll(result);
      });
    });*/
  }

  removechapter(String subjectname, String id) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    var d = await http.post(url, body: {
      "action": "remove_chapter",
      "subjectname": subjectname,
      "id": id
    }).whenComplete(() {
      Toast.Toast.show("that subject is removed", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      //Navigator.pop(context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => get_chapter()));
    });
    /*database_professor()
        .remove_chapter_tosqlite(subjectname, id)
      ;*/
  }

  Widget get_queation() {
    int i = 0;
    print(data);
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index]['subjectname'] == subjectvalue) {
                i++;
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text("Chapter $i :${data[index]['chaptername']}"),
                      FlatButton(
                        onPressed: () {
                          removechapter(subjectvalue, data[index]['ID']);
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
    // TODO: implement build
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
                  value: subjectvalue,
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
                      subjectvalue = value;
                    });
                  },
                )),
            Expanded(child: get_queation())
          ],
        ),
      ),
    ));
  }
}
