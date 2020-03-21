import 'package:exam/Admin/get_subject.dart';
import 'package:exam/Database/Database_professor.dart';
import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class showquestionbank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return showquestionbankpage();
  }
}

class showquestionbankpage extends State<showquestionbank> {
  String subjectvalue;
  List sub = ["MCQ", "TRUE&FAULSE"];
  List data = new List();
  void subject() async {
    Databasestudent().getthequeationmcq().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
    data = List.from(data.reversed);
  }

  List data1 = new List();

  void subject1() async {
    Databasestudent().getthequeationtrueandfalse().then((result) {
      setState(() {
        data1.addAll(result);
      });
    });
    data1 = List.from(data1.reversed);
  }

  @override
  void initState() {
    super.initState();
    subject();
    subject1();
  }

  Widget get_queation() {
    return Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: <Widget>[
                  Text("Subject Question :${data[index]['ID']}"),
                  Text("Subject Question :${data[index]['Question']}"),
                  Text("Subject subject :${data[index]['subject']}"),
                  Text(
                      "Subject numberofchapter :${data[index]['numberofchapter']}"),
                  Text("Subject level :${data[index]['level']}"),
                  Text("Subject answer1 :${data[index]['answer1']}"),
                  Text("Subject answer2 :${data[index]['answer2']}"),
                  Text("Subject answer3 :${data[index]['answer3']}"),
                  Text("Subject answer4 :${data[index]['answer4']}"),
                  Text(
                      "Subject correctanswer :${data[index]['correctanswer']}"),
                  Text("bank:${data[index]['bank']}"),
                ],
              ));
            }));
  }

  Widget get_queation1() {
    return Container(
        child: ListView.builder(
            itemCount: data1.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: <Widget>[
                  Text("Subject Question :${data1[index]['ID']}"),
                  Text("Subject Question :${data1[index]['Question']}"),
                  Text("Subject subject :${data1[index]['subject']}"),
                  Text(
                      "Subject numberofchapter :${data1[index]['numberofchapter']}"),
                  Text("Subject level :${data1[index]['level']}"),
                  Text("Subject answer1 :${data1[index]['answer1']}"),
                  Text("Subject answer2 :${data1[index]['answer2']}"),
                  Text("Subject answer3 :${data1[index]['answer3']}"),
                  Text("Subject answer4 :${data1[index]['answer4']}"),
                  Text(
                      "Subject correctanswer :${data1[index]['correctanswer']}"),
                  Text("bank:${data1[index]['bank']}"),
                ],
              ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Color(0xff2e2e2e),
      body: Container(
          child: Column(
        children: <Widget>[
          DropdownButtonFormField<dynamic>(
            value: subjectvalue,
            items: sub
                .map((label) => DropdownMenuItem(
                      child: Text(label.toString()),
                      value: label,
                    ))
                .toList(),
            hint: Text('Type of question :'),
            onChanged: (value) {
              setState(() {
                subjectvalue = value;
              });
            },
          ),
          subjectvalue == "TRUE&FAULSE"
              ? Container(child: Expanded(child: get_queation1()))
              : Container(child: Expanded(child: get_queation()))
        ],
      )),
    ));
  }
}
