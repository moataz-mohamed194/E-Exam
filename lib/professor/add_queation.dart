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
  List number = [];
  List trueandfalseanswer = [" ", "True", "False"];
  List mcqanswer = [" ", "", "", "", ""];
  List level = [" ", "A", "B", "C"];
  List sub = [" "];
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
      number.add(i);
    }
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
        data[sub_data[i]['Name'].toString()] =
            int.parse(sub_data[i]['counter']);
      }
    });
  }

  void addquestionmcq(
      String question,
      String subject,
      String numberofchapter,
      String level,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      String correctanswer) {
    database_professor()
        .add_question_mcq_tosqlite(
            question,
            subject,
            numberofchapter,
            level,
            answer1,
            answer2,
            answer3,
            answer4,
            correctanswer,
            _value1.toString())
        .whenComplete(() {
      Toast.Toast.show("that queation is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    }).catchError(() {});
  }

  void addquestiontrue_and_false(String question, String subject,
      String numberofchapter, String correctanswer) {
    database_professor()
        .add_question_true_and_false_tosqlite(question, subject,
            numberofchapter, correctanswer, _value1.toString())
        .whenComplete(() {
      Toast.Toast.show("that queation is add", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
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
            onChanged: (q) {
              mcqanswer[1] = q;
            },
            textInputAction: TextInputAction.next,
            onSaved: (input) => answer1save = input,
            decoration: InputDecoration(
              labelText: "answer1",
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
          ),
          TextFormField(
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
            onChanged: (q) {
              mcqanswer[3] = q;
            },
            onSaved: (input) => answer3save = input,
            decoration: InputDecoration(
              labelText: "answer3",
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
          ),
          TextFormField(
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

  bool _value1 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
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
                      number.clear();
                      enternumberchapter(subjectvalue);
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
                CheckboxListTile(
                  value: _value1,
                  onChanged: _value1Changed,
                  title: new Text('Add queation to student\'s bank'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                FlatButton(
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
                        addquestiontrue_and_false(question.text, subjectvalue,
                            numbervalue, trueandfalsevalue);
                      }
                    }
                  },
                  child: Text("add department"),
                  color: Colors.blue,
                ),
              ],
            )),
      ),
    ));
  }
}
