import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GetExam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetExamPage();
  }
}

class GetExamPage extends State<GetExam> {
  List data = new List();

  List data1 = new List();
  GlobalState _store = GlobalState.instance;
  //send name of subject and id and get the question will be in exam
  void mcq() async {
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http.post(url, body: {
      "action": "getExam",
      "subject": "${_store.get('examsubject')}",
      "id": "${_store.get('idexam')}"
    });
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
  }

  @override
  void initState() {
    super.initState();
    mcq();
  }

  int i = 0;
  bool answer = false;
  String button1 = "null";
  String button2 = "null";
  String button3 = "null";
  String button4 = "null";
  //count of correct answer
  int count = 0;
  //the UI of questions
  Widget getMCQExam() {
    if (data.isNotEmpty) {
      return Container(
        child: data[i]['answer1'] != null
            ? Column(
                children: <Widget>[
                  Text(
                    "${i + 1}. ${data[i]['Question']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                  data[i]['answer1'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer1']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button1 == "null"
                                ? Colors.blue
                                : button1 == "correct"
                                    ? Colors.green
                                    : button1 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });
                                if (data[i]['answer1'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button1 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button1 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer2'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer2']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button2 == "null"
                                ? Colors.blue
                                : button2 == "correct"
                                    ? Colors.green
                                    : button2 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer2'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button2 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button2 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer3'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer3']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button3 == "null"
                                ? Colors.blue
                                : button3 == "correct"
                                    ? Colors.green
                                    : button3 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer3'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button3 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button3 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer4'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer4']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button4 == "null"
                                ? Colors.blue
                                : button4 == "correct"
                                    ? Colors.green
                                    : button4 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer4'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button4 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button4 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  /*Card(
                    child: Column(
                      children: <Widget>[
                        Text(data[i]['subject']),
                        Text(data[i]['numberofchapter']),
                        Text(data[i]['level']),
                        Text(data[i]['correctanswer']),
                      ],
                    ),
                  )*/
                ],
              )
            : Column(
                children: <Widget>[
                  Text("${i + 1}. ${data[i]['Question']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20)),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: RaisedButton(
                        child: new Text("true"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: button1 == "null"
                            ? Colors.blue
                            : button1 == "correct"
                                ? Colors.green
                                : button1 == "false" ? Colors.red : Colors.blue,
                        onPressed: () {
                          if (answer == false) {
                            setState(() {
                              answer = true;
                            });

                            if (data[i]['correctanswer'] == "True") {
                              setState(() {
                                button1 = "correct";
                                count++;
                              });
                            } else {
                              setState(() {
                                button1 = "false";
                              });
                            }
                          }
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: RaisedButton(
                        child: new Text("false"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: button2 == "null"
                            ? Colors.blue
                            : button2 == "correct"
                                ? Colors.green
                                : button2 == "false" ? Colors.red : Colors.blue,
                        onPressed: () {
                          if (answer == false) {
                            setState(() {
                              answer = true;
                            });

                            if (data[i]['correctanswer'] == "False") {
                              setState(() {
                                button2 = "correct";
                                count++;
                              });
                            } else {
                              setState(() {
                                button2 = "false";
                              });
                            }
                          }
                        },
                      )),
                  /*Card(
                    child: Column(
                      children: <Widget>[
                        Text(data[i]['subject']),
                        Text(data[i]['numberofchapter']),
                        Text(data[i]['correctanswer']),
                      ],
                    ),
                  )*/
                ],
              ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  //the result of exam
  _onAlertWithCustomImagePressed(
      context, String title, double result, String img) {
    Alert(
      context: context,
      title: "$title",
      desc: "Result:$result %",
      image: Image.asset("$img"),
      buttons: [
        DialogButton(
          child: Text(
            "Finish",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Exam"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (i == data.length - 1) {
              String word, img;
              double final1 = count / data.length;
              double final2 = final1 * 100;
              double final3 = double.parse(final2.toStringAsFixed(2));
              if (final2 >= 50.0) {
                word = 'You Passed';
                img = 'img/success.png';

                _onAlertWithCustomImagePressed(context, word, final3, img);
              } else {
                word = 'You Failed';
                img = 'img/failed.png';
                _onAlertWithCustomImagePressed(context, word, final3, img);
              }
            } else {
              i++;
              answer = false;
              button1 = "null";
              button2 = "null";
              button3 = "null";
              button4 = "null";
            }
          });
        },
        child: Icon(Icons.navigate_next),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[getMCQExam() /*, Text("$count")*/],
        ),
      ),
    ));
  }
}
