import 'package:exam/Database/Database_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class getexam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return getexampage();
  }
}

class getexampage extends State<getexam> {
  List data = new List();
  void mcq() async {
    Databasestudent().mcqexam().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
    //  data.removeAt(0);
  }

  void trueandfalse() async {
    Databasestudent().trueandfalseexam().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
    //  data.removeAt(0);
  }

  @override
  void initState() {
    super.initState();
    mcq();
    trueandfalse();
  }

  int i = 0;
  bool answer = false;
  String button1 = "null";
  String button2 = "null";
  String button3 = "null";
  String button4 = "null";
  int count = 0;
  check(String first, String second, String third, String fourth,
      String answer) {}
  Widget getmcqexam() {
    return Container(
      child: data[i]['answer1'] != null
          ? Column(
              children: <Widget>[
                Text(data[i]['Question']),
                new RaisedButton(
                  child: new Text(data[i]['answer1']),
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
                      if (data[i]['answer1'] == data[i]['correctanswer']) {
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
                    print(answer);
                    print(button1);
                  },
                ),
                new RaisedButton(
                  child: new Text(data[i]['answer2']),
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

                      if (data[i]['answer2'] == data[i]['correctanswer']) {
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
                ),
                new RaisedButton(
                  child: new Text(data[i]['answer3']),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: button3 == "null"
                      ? Colors.blue
                      : button3 == "correct"
                          ? Colors.green
                          : button3 == "false" ? Colors.red : Colors.blue,
                  onPressed: () {
                    if (answer == false) {
                      setState(() {
                        answer = true;
                      });

                      if (data[i]['answer3'] == data[i]['correctanswer']) {
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
                ),
                new RaisedButton(
                  child: new Text(data[i]['answer4']),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: button4 == "null"
                      ? Colors.blue
                      : button4 == "correct"
                          ? Colors.green
                          : button4 == "false" ? Colors.red : Colors.blue,
                  onPressed: () {
                    if (answer == false) {
                      setState(() {
                        answer = true;
                      });

                      if (data[i]['answer4'] == data[i]['correctanswer']) {
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
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(data[i]['subject']),
                      Text(data[i]['numberofchapter']),
                      Text(data[i]['level']),
                      Text(data[i]['correctanswer']),
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: <Widget>[
                Text(data[i]['Question']),
                new RaisedButton(
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
                ),
                new RaisedButton(
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
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(data[i]['subject']),
                      Text(data[i]['numberofchapter']),
                      Text(data[i]['correctanswer']),
                    ],
                  ),
                )
              ],
            ),
    );
  }

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
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
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
/*      bottomNavigationBar: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next),
      ),*/
      body: Container(
        child: Column(
          children: <Widget>[getmcqexam(), Text("$count")],
        ),
      ),
    ));
  }
}
