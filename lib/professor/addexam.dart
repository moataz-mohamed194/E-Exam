import 'dart:convert';
import 'package:get/get.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'DynamicDialogPage.dart';

class AddExam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddExamPage();
  }
}

class AddExamPage extends State<AddExam> {
  String numberValue;
  var date;
  String label;
  EdgeInsets padding;
  bool value;
  Function onChanged;
  TextEditingController timeOfExam;
  GlobalState _store = GlobalState.instance;
  final _formKey = GlobalKey<FormState>();
  String subjectValue, chapterValue;
  List sub = [];
  String timeValue;
  List time = ["1 Hours", "2 Hours", "3 Hours"];
  List chapterList = ["MCQ", "True&False", "Both"];
  List subData = new List();
  Map data = new Map<String, int>();
  List number = [];
  var pp;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  final examChapter = Map<String, String>();

  void enterNumberChapter(String name) {
    int j = data[name];
    for (int i = 1; i <= j; i++) {
      number.add("$i");
    }
  }

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
      setState(() {
        sub.add(subData[i]['Name']);
        data[subData[i]['Name'].toString()] = int.parse(subData[i]['counter']);
      });
    }
  }

  void initState() {
    super.initState();
    nameOfSubject();
    timeOfExam = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LanguageView(),
                          fullscreenDialog: true),
                    );
                  },
                )
              ],
              backgroundColor: Color(0xff254660),
              title: Text(
                  'addExam'.trArgs() ),
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
                  child: ListView(scrollDirection: Axis.vertical, children: <
                      Widget>[
                    Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButtonFormField<dynamic>(
                          value: subjectValue,
                          validator: (value) {
                            if (value == null) {
                              return 'enterTheSubject'.trArgs() ;
                            } else if (value == " ") {
                              return 'enterTheSubject'.trArgs() ;
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
                          hint: Text(
                              '${'subject'.trArgs() } :'),
                          onChanged: (value) {
                            setState(() {
                              subjectValue = value;
                              number.clear();
                              enterNumberChapter(subjectValue);
                              numberValue = number[0];
                            });
                          },
                        )),
                    Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DateTimeField(
                          format: format,
                          decoration: InputDecoration(
                            labelText:
                                "whenTheExamWillBe".trArgs() ,
                            hintText:
                                "enterWhenTheExamWillBe".trArgs() ,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "enterTheTimeOfExam".trArgs();
                            } else {
                              return null;
                            }
                          },
                          controller: timeOfExam,
                          onShowPicker: (context, currentValue) async {
                            date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.combine(date, time);
                            } else {
                              return currentValue;
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
                          value: timeValue,
                          validator: (value) {
                            if (value == null) {
                              return "enterTheTime".trArgs();
                            } else if (value == " ") {
                              return 'enterTheTime'.trArgs();
                            } else {
                              return null;
                            }
                          },
                          items: time
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                              '${'howLongOfYourExam'.trArgs() } :'),
                          onChanged: (value) {
                            setState(() {
                              timeValue = value;
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
                          value: numberValue,
                          validator: (value) {
                            if (value == null && numberValue == null) {
                              return "enterNumberOfChapter".trArgs();
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
                          hint: Text(
                              '${'numberOfChapter'.trArgs() } :'),
                          onChanged: (value) {
                            setState(() {
                              numberValue = value;
                            });
                          },
                        )),
                    Card(
                        color: Colors.blue,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: FlatButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _store.set("numberValue", "$numberValue");
                                  showDialog(
                                      context: context,
                                      builder: ((BuildContext context) {
                                        //subjectValue, timeOfExam.text,
                                        // timeValue
                                        return DynamicDialog(
                                            title: '$subjectValue',
                                            examSubject: subjectValue,
                                            examTime: timeOfExam.text,
                                            examDurationOfTheExam: timeValue);
                                      }));
                                }
                              },
                              child: Text(
                                  'chooseChapter'.trArgs() ,
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            ))),
                  ]),
                ))));
  }
}
