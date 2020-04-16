import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class show_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return show_questionpage();
  }
}

class show_questionpage extends State<show_question> {
  String subjectvalue;
  List sub = ["MCQ", "TRUE&FAULSE"];
  List data = new List();

  @override
  void initState() {
    super.initState();
    subject();
    subject1();
  }

  GlobalState _store = GlobalState.instance;

  void subject() async {
    /*database_professor().get_the_queation_mcq().then((result) {
      setState(() {
        data.addAll(result);
      });
    });*/
    var url = "http://${_store.ipaddress}/app/professor.php";
    final response =
        await http.post(url, body: {"action": "get_the_queation_mcq"});
    print(response.body);
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    data = List.from(data.reversed);
  }

  List data1 = new List();

  void subject1() async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    final response = await http
        .post(url, body: {"action": "get_the_queationtrue_and_false"});
    print(response.body);
    String content = response.body;
    setState(() {
      data1 = json.decode(content);
    });
    /*database_professor().get_the_queationtrue_and_false().then((result) {
      setState(() {
        data1.addAll(result);
      });
    });*/
    data1 = List.from(data1.reversed);
  }

  var d;
  remove_mcq_question(String id) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    d = await http.post(url,
        body: {"action": "remove_mcq_question", "id": id}).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => show_question()));
    });
    print(d.body);
  }

  remove_true_and_false_question(String id) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    d = await http.post(url, body: {
      "action": "queastion_true_and_false",
      "id": id
    }).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => show_question()));
    });
    print(d.body);
  }

  Widget get_queation() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: <Widget>[
                  Text("Subject :${data[index]['subject']}"),
                  Text("Chapter :${data[index]['numberofchapter']}"),
                  Text("level :${data[index]['level']}"),
                  Text("Question :${data[index]['Question']}?"),
                  Text("(A)${data[index]['answer1']}"),
                  Text("(B)${data[index]['answer2']}"),
                  Text("(C)${data[index]['answer3']}"),
                  Text("(D)${data[index]['answer4']}"),
                  Text("Correct answer :${data[index]['correctanswer']}"),
                  Text("Added to bank:${data[index]['bank']}"),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        remove_mcq_question(data[index]['ID']);
                        /*database_professor()
                            .remove_mcq_question(data[index]['ID'])
                            .whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => show_question()));
                        });*/
                      },
                      child: Text("remove queation",
                          style: TextStyle(color: Colors.white)))
                ],
              ));
            }));
  }

  Widget get_queation1() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data1.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: <Widget>[
                  Text("Subject:${data1[index]['subject']}"),
                  Text("Chapter :${data1[index]['numberofchapter']}"),
                  Text("Question:${data1[index]['Question']}?"),
                  Text("Correct answer :${data1[index]['correctanswer']}"),
                  Text("Added to bank:${data1[index]['bank']}"),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        remove_true_and_false_question(data1[index]['ID']);
                        /* database_professor()
                            .remove_true_and_false_question(data1[index]['ID'])
                            .whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => show_question()));
                        });*/
                      },
                      child: Text("remove queation",
                          style: TextStyle(color: Colors.white)))
                ],
              ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Show Questions"),
      ),
      backgroundColor: Color(0xff2e2e2e),
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
              subjectvalue == "TRUE&FAULSE"
                  ? Container(
                      child: Expanded(child: get_queation1()),
                    )
                  : Container(child: Expanded(child: get_queation()))
            ],
          )),
    ));
  }
}
