import 'dart:convert';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class add_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return add_questionpage();
  }
}

enum SingingCharacter { lafayette, jefferson }

class add_questionpage extends State<add_question> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode questionnode = FocusNode();
  final FocusNode answer1node = FocusNode();
  final FocusNode answer2node = FocusNode();
  final FocusNode answer3node = FocusNode();
  final FocusNode answer4node = FocusNode();
  TextEditingController question;
  TextEditingController answer1;
  TextEditingController answer2;
  TextEditingController answer3;
  TextEditingController answer4;
  String questionsave, answer1save, answer2save, answer3save, answer4save;
  List number = [];
  List trueandfalseanswer = ["True", "False"];
  List mcqanswer = ["", "", "", ""];
  List level = ["A", "B", "C"];
  List sub = [];
  SingingCharacter _character = SingingCharacter.lafayette;

  void initState() {
    super.initState();
    nameofsubject();
    question = new TextEditingController();
    answer1 = new TextEditingController();
    answer2 = new TextEditingController();
    answer3 = new TextEditingController();
    answer4 = new TextEditingController();
  }

  Map data = new Map<String, int>();

  void enternumberchapter(String name) {
    int j = data[name];
    print(j);
    for (int i = 1; i <= j; i++) {
      number.add(i.toString());
    }
  }

  GlobalState _store = GlobalState.instance;

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      data[sub_data[i]['Name'].toString()] = int.parse(sub_data[i]['counter']);
    }
  }

  var b2;
  Future<void> addquestionmcq(
      String question,
      String subject,
      String numberofchapter,
      String level,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      String correctanswer) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    b2 = await http.post(url, body: {
      "action": "add_question_mcq_tosqlite",
      "question": question,
      "subject": subject,
      "numberofchapter": numberofchapter,
      "level": level,
      "answer1": answer1,
      "answer2": answer2,
      "answer3": answer3,
      "answer4": answer4,
      "correctanswer": correctanswer,
      "bank": _value1.toString()
    }).whenComplete(() {
      Toast.Toast.show("that queation is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
    print(b2.body);
  }

  var b1;
  Future<void> addquestiontrue_and_false(String question, String subject,
      String numberOfChapter, String correctAnswer) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    b1 = await http.post(url, body: {
      "action": "add_question_true_and_false_tosqlite",
      "question": question,
      "subject": subject,
      "numberofchapter": numberOfChapter,
      "correctanswer": correctAnswer,
      "bank": _value1.toString()
    }).whenComplete(() {
      Toast.Toast.show("that queation is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
    print(b1.body);
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String trueandfalsevalue, levelvalue, mcqvalue, subjectvalue, numbervalue;
  bool mcq = true;
  Widget the_answer_of_mcq() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: levelvalue,
                validator: (value) {
                  if (value == null) {
                    return 'Enter the Level of queation';
                  } else if (value == " ") {
                    return 'Enter the Level of queation';
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
                hint: Text('Level of queation :'),
                onChanged: (value) {
                  setState(() {
                    levelvalue = value;
                  });
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer1,
                focusNode: answer1node,
                onChanged: (q) {
                  mcqanswer[1] = q;
                },
                textInputAction: TextInputAction.next,
                onSaved: (input) => answer1save = input,
                decoration: InputDecoration(
                  labelText: "answer1",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: "Enter answer1",
                ),
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer1node, answer2node);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter answer1';
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer2,
                focusNode: answer2node,
                textInputAction: TextInputAction.next,
                onChanged: (q) {
                  mcqanswer[2] = q;
                },
                onSaved: (input) {
                  answer2save = input;
                },
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer2node, answer3node);
                },
                decoration: InputDecoration(
                  labelText: "answer2",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: "Enter answer2",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter answer2';
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer3,
                focusNode: answer3node,
                textInputAction: TextInputAction.next,
                onChanged: (q) {
                  mcqanswer[3] = q;
                },
                onSaved: (input) => answer3save = input,
                decoration: InputDecoration(
                  labelText: "answer3",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: "Enter answer3",
                ),
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer3node, answer4node);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter answer3';
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer4,
                focusNode: answer4node,
                textInputAction: TextInputAction.done,
                onChanged: (q) {
                  mcqanswer[4] = q;
                },
                onSaved: (input) => answer4save = input,
                decoration: InputDecoration(
                  labelText: "answer4",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: "Enter answer4",
                ),
                onFieldSubmitted: (input) {
                  answer4node.unfocus();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter answer4';
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: mcqvalue,
                validator: (value) {
                  if (value == null) {
                    return 'Enter the correct Answer';
                  } else if (value == " ") {
                    return 'Enter the correct Answer';
                  } else {
                    return null;
                  }
                },
                items: mcqanswer
                    .map((label) => DropdownMenuItem(
                          child: Text(label.toString()),
                          value: label,
                        ))
                    .toList(),
                hint: Text('Answer :'),
                onChanged: (value) {
                  setState(() {
                    mcqvalue = value;
                  });
                },
              ))
        ],
      ),
    );
  }

  bool trueandfalse = false;
  Widget true_and_false_question() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: trueandfalsevalue,
                validator: (value) {
                  if (value == null) {
                    return 'Enter the correct Answer';
                  } else if (value == " ") {
                    return 'Enter the correct Answer';
                  } else {
                    return null;
                  }
                },
                items: trueandfalseanswer
                    .map((label) => DropdownMenuItem(
                          child: Text(label.toString()),
                          value: label,
                        ))
                    .toList(),
                hint: Text('Answer :'),
                onChanged: (value) {
                  setState(() {
                    trueandfalsevalue = value;
                  });
                },
              )),
        ],
      ),
    );
  }

  bool _value1 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Add Question"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55,
                        top: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: question,
                      focusNode: questionnode,
                      textInputAction: TextInputAction.next,
                      onSaved: (input) => questionsave = input,
                      decoration: InputDecoration(
                        labelText: "question",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Enter question",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter question';
                        } else {
                          return null;
                        }
                      },
                    )),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: subjectvalue,
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
                          subjectvalue = value;
                          number.clear();
                          enternumberchapter(subjectvalue);
                        });
                      },
                    )),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55,
                    ),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: numbervalue,
                      validator: (value) {
                        if (value == null) {
                          return 'Enter number of chapter';
                        } else if (value == " ") {
                          return 'Enter number of chapter';
                        } else {
                          return null;
                        }
                      },
                      items: number
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      hint: Text('Number of chapter :'),
                      onChanged: (value) {
                        setState(() {
                          numbervalue = value;
                        });
                      },
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'MCQ',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: SingingCharacter.lafayette,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              mcq = true;
                              trueandfalse = false;
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'True&\nFalse',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: SingingCharacter.jefferson,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              trueandfalse = true;
                              mcq = false;
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                mcq == true ? the_answer_of_mcq() : Container(),
                trueandfalse == true ? true_and_false_question() : Container(),
                CheckboxListTile(
                  value: _value1,
                  checkColor: Colors.white,
                  onChanged: _value1Changed,
                  title: new Text(
                    'Add to student\'s bank',
                    style: TextStyle(color: Colors.white),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Card(
                    color: Colors.blue,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (mcq == true && trueandfalse == false) {
                                print("mcq");
                                addquestionmcq(
                                    question.text,
                                    subjectvalue,
                                    numbervalue,
                                    levelvalue,
                                    answer1.text,
                                    answer2.text,
                                    answer3.text,
                                    answer4.text,
                                    mcqvalue);
                              } else if (trueandfalse == true && mcq == false) {
                                print("true&&fal");
                                addquestiontrue_and_false(
                                    question.text,
                                    subjectvalue,
                                    numbervalue,
                                    trueandfalsevalue);
                              }
                            }
                          },
                          child: Text("Add Question",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ))),
              ],
            )),
      ),
    );
  }
}
