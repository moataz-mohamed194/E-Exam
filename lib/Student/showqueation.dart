import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showquestionbank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return showquestionbankpage();
  }
}

class showquestionbankpage extends State<showquestionbank> {
  String subjectvalue, subjectvalue1;
  List sub = ["MCQ", "TRUE&FALSE"];
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

  List sub_data1 = new List();
  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Databasestudent()
        .getstudentsubject(prefs.getString('level'))
        .then((result) {
      setState(() {
        sub_data1.addAll(result);

        print("rrrr");
      });
      for (int i = 0; i < sub_data1.length; i++) {
        setState(() {
          sub_data.add(sub_data1[i]['Name']);
          //  print("object");
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subject();
    subject1();
    nameofsubject();
  }

  Widget get_queation() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (subjectvalue1 == null) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("${data[index]['subject']}"),
                    Text("chapter :${data[index]['numberofchapter']}"),
                    Text(" level :${data[index]['level']}"),
                    Text("Question :${data[index]['Question']} ?"),
                    Text("A :${data[index]['answer1']}"),
                    Text("B :${data[index]['answer2']}"),
                    Text("C :${data[index]['answer3']}"),
                    Text("D :${data[index]['answer4']}"),
                    Text("correct answer:${data[index]['correctanswer']}"),
                    Text("bank:${data[index]['bank']}"),
                  ],
                ));
              } else if (subjectvalue1 != null &&
                  data[index]['subject'] == subjectvalue1) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("${data[index]['subject']}"),
                    Text("Chapter :${data[index]['numberofchapter']}"),
                    Text("level :${data[index]['level']}"),
                    Text("Question :${data[index]['Question']}"),
                    Text("(A) ${data[index]['answer1']}"),
                    Text("(B) ${data[index]['answer2']}"),
                    Text("(C) ${data[index]['answer3']}"),
                    Text("(D) ${data[index]['answer4']}"),
                    Text("Correct answer :${data[index]['correctanswer']}"),
                    Text("bank:${data[index]['bank']}"),
                  ],
                ));
              } else {
                return Container();
              }
            }));
  }

  Widget get_queation1() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data1.length,
            itemBuilder: (context, index) {
              if (subjectvalue1 == null) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("Question :${data1[index]['Question']}"),
                    Text("${data1[index]['subject']}"),
                    Text("Chapter :${data1[index]['numberofchapter']}"),
                    Text("Correct answer :${data1[index]['correctanswer']}"),
                    Text("Bank:${data1[index]['bank']}"),
                  ],
                ));
              } else if (subjectvalue1 != null &&
                  data1[index]['subject'] == subjectvalue1) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("Question :${data1[index]['Question']}"),
                    Text("${data1[index]['subject']}"),
                    Text("Chapter :${data1[index]['numberofchapter']}"),
                    Text("Correct answer :${data1[index]['correctanswer']}"),
                    Text("Bank:${data1[index]['bank']}"),
                  ],
                ));
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
        title: Text("Question Bank"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: DropdownButtonFormField<dynamic>(
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
                  )),
              Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: DropdownButtonFormField<dynamic>(
                    value: subjectvalue1,
                    items: sub_data
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Subject :'),
                    onChanged: (value) {
                      setState(() {
                        subjectvalue1 = value;
                      });
                    },
                  )),
              subjectvalue == "TRUE&FALSE"
                  ? Container(child: Expanded(child: get_queation1()))
                  : Container(child: Expanded(child: get_queation()))
            ],
          )),
    ));
  }
}
