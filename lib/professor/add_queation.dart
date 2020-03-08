import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class add_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
  List number = [" ", "1", "2", "3", "4", "5"];
  List trueandfalseanswer = [" ", "True", "False"];
  List mcqanswer = [" "];
  List level = [" ", "A", "B", "C"];
  List sub = [" "];
  SingingCharacter _character = SingingCharacter.lafayette;

  void initState() {
    super.initState();
    countofchapter();
    nameofsubject();
    question = new TextEditingController();
    answer1 = new TextEditingController();
    answer2 = new TextEditingController();
    answer3 = new TextEditingController();
    answer4 = new TextEditingController();
  }

  List sub_data = new List();
  void nameofsubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    database_professor()
        .get_the_subject(prefs.getString('realName'))
        .then((result) {
      setState(() {
        sub_data.addAll(result);
      });
      print(sub_data);
      for (int i = 0; i < result.length; i++) {
        sub.add(sub_data[i]['Name']);
      }
    });
  }

  List number_chapter = new List();
  void countofchapter() async {
    database().Leader_of_department().then((result) {
      setState(() {
        number_chapter.addAll(result);
      });
      for (int i = 0; i < result.length; i++) {
        number.add(number_chapter[i]['realName']);
      }
    });
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
          DropdownButtonFormField<dynamic>(
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
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: answer1,
            focusNode: answer1node,
            textInputAction: TextInputAction.next,
            onSaved: (input) => answer1save = input,
            decoration: InputDecoration(
              labelText: "answer1",
              hintText: "Enter answer1",
            ),
            onFieldSubmitted: (input) {
              _fieldFocusChange(context, answer1node, answer2node);
              setState(() {
                mcqanswer.add(answer1.text);
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter answer1';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: answer2,
            focusNode: answer2node,
            textInputAction: TextInputAction.next,
            onSaved: (input) {
              answer2save = input;
            },
            onFieldSubmitted: (input) {
              _fieldFocusChange(context, answer2node, answer3node);
              setState(() {
                mcqanswer.add(answer2.text);
              });
            },
            decoration: InputDecoration(
              labelText: "answer2",
              hintText: "Enter answer2",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter answer2';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: answer3,
            focusNode: answer3node,
            textInputAction: TextInputAction.next,
            onSaved: (input) => answer3save = input,
            decoration: InputDecoration(
              labelText: "answer3",
              hintText: "Enter answer3",
            ),
            onFieldSubmitted: (input) {
              _fieldFocusChange(context, answer3node, answer4node);
              setState(() {
                mcqanswer.add(answer3.text);
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter answer3';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: answer4,
            focusNode: answer4node,
            textInputAction: TextInputAction.done,
            onSaved: (input) => answer4save = input,
            decoration: InputDecoration(
              labelText: "answer4",
              hintText: "Enter answer4",
            ),
            onFieldSubmitted: (input) {
              answer4node.unfocus();
              setState(() {
                mcqanswer.add(answer4.text);
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter answer4';
              } else {
                return null;
              }
            },
          ),
          DropdownButtonFormField<dynamic>(
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
          )
        ],
      ),
    );
  }

  bool trueandfalse = false;
  Widget true_and_false_question() {
    return Container(
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<dynamic>(
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: question,
                focusNode: questionnode,
                textInputAction: TextInputAction.next,
                onSaved: (input) => questionsave = input,
                decoration: InputDecoration(
                  labelText: "question",
                  hintText: "Enter question",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter question';
                  } else {
                    return null;
                  }
                },
              ),
              DropdownButtonFormField<dynamic>(
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
                  });
                },
              ),
              DropdownButtonFormField<dynamic>(
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
              ),
              ListTile(
                title: const Text('True & False'),
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
              ListTile(
                title: const Text('MCQ'),
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
              mcq == true ? the_answer_of_mcq() : Container(),
              trueandfalse == true ? true_and_false_question() : Container(),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
                child: Text("add department"),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
