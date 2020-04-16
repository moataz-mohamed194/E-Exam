import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart' as Toast;

import 'package:http/http.dart' as http;

class addexam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addexampage();
  }
}

class addexampage extends State<addexam> {
  final _formKey = GlobalKey<FormState>();
  String subjectvalue, numbervalue, chaptervalue;
  List sub = [];
  String timevalue;
  List time = ["1 Hours", "2 Hours", "3 Hours"];
  List chapterlist = ["MCQ", "True&False", "Both"];
  List subdata = new List();
  Map data = new Map<String, int>();
  List number = [];
  String trueandfalse_1,
      trueandfalse_2,
      trueandfalse_3,
      trueandfalse_4,
      trueandfalse_5;
  List listtrueandfalse1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List listtrueandfalse2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List listtrueandfalse3 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List listtrueandfalse4 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List listtrueandfalse5 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  String mcq_a1, mcq_a2, mcq_a3, mcq_a4, mcq_a5;
  String mcq_b1, mcq_b2, mcq_b3, mcq_b4, mcq_b5;
  String mcq_c1, mcq_c2, mcq_c3, mcq_c4, mcq_c5;
  List list_mcq_a1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_a2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_a3 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_a4 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_a5 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  List list_mcq_b1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_b2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_b3 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_b4 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_b5 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  List list_mcq_c1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_c2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_c3 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_c4 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List list_mcq_c5 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  void enternumberchapter(String name) {
    int j = data[name];
    for (int i = 1; i <= j; i++) {
      number.add("$i");
    }
  }

  GlobalState _store = GlobalState.instance;

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
      subdata = json.decode(content);
    });

    /* database_professor()
        .get_the_subject(prefs.getString('realName'))
        .then((result) {
      setState(() {
        subdata.addAll(result);
      });*/
    for (int i = 0; i < subdata.length; i++) {
      setState(() {
        sub.add(subdata[i]['Name']);
        data[subdata[i]['Name'].toString()] = int.parse(subdata[i]['counter']);
      });
    }
    //  });
  }

  String label;
  EdgeInsets padding;
  bool value;
  Function onChanged;
  TextEditingController timeofexam;

  void initState() {
    super.initState();
    nameofsubject();
    timeofexam = new TextEditingController();
  }

  bool mcq1 = false;
  bool truenandfalse1 = false;
  bool mcq2 = false;
  bool truenandfalse2 = false;
  bool mcq3 = false;
  bool truenandfalse3 = false;
  bool mcq4 = false;
  bool truenandfalse4 = false;
  bool mcq5 = false;
  bool truenandfalse5 = false;

  void mcq1Changed(bool value) {
    setState(() {
      mcq1 = value;
    });
    setState(() {
      if (mcq1 == false) {
        examchapter.remove("chapter1mcqc");
        examchapter.remove("chapter1mcqa");
        examchapter.remove("chapter1mcqb");
      }
    });
  }

  void trueandfalse1Changed(bool value) {
    setState(() {
      truenandfalse1 = value;
    });
    setState(() {
      if (truenandfalse1 == false) {
        examchapter.remove("chapter1trueandfalse");
      }
    });
  }

  void mcq2Changed(bool value) {
    setState(() {
      mcq2 = value;
    });
    setState(() {
      if (mcq2 == false) {
        examchapter.remove("chapter2mcqc");
        examchapter.remove("chapter2mcqa");
        examchapter.remove("chapter2mcqb");
      }
    });
  }

  void trueandfalse2Changed(bool value) {
    setState(() {
      truenandfalse2 = value;
    });

    setState(() {
      if (truenandfalse2 == false) {
        examchapter.remove("chapter2trueandfalse");
      }
    });
  }

  void mcq3Changed(bool value) {
    setState(() {
      mcq3 = value;
    });
    setState(() {
      if (mcq3 == false) {
        examchapter.remove("chapter3mcqc");
        examchapter.remove("chapter3mcqa");
        examchapter.remove("chapter3mcqb");
      }
    });
  }

  void trueandfalse3Changed(bool value) {
    setState(() {
      truenandfalse3 = value;
    });

    setState(() {
      if (truenandfalse3 == false) {
        examchapter.remove("chapter3trueandfalse");
      }
    });
  }

  void mcq4Changed(bool value) {
    setState(() {
      mcq4 = value;
    });
    setState(() {
      if (mcq4 == false) {
        examchapter.remove("chapter4mcqc");
        examchapter.remove("chapter4mcqa");
        examchapter.remove("chapter4mcqb");
      }
    });
  }

  void trueandfalse4Changed(bool value) {
    setState(() {
      truenandfalse4 = value;
    });

    setState(() {
      if (truenandfalse4 == false) {
        examchapter.remove("chapter4trueandfalse");
      }
    });
  }

  void mcq5Changed(bool value) {
    setState(() {
      mcq5 = value;
    });
    setState(() {
      if (mcq5 == false) {
        examchapter.remove("chapter5mcqc");
        examchapter.remove("chapter5mcqa");
        examchapter.remove("chapter5mcqb");
      }
    });
  }

  void trueandfalse5Changed(bool value) {
    setState(() {
      truenandfalse5 = value;
    });
    setState(() {
      if (truenandfalse5 == false) {
        examchapter.remove("chapter5trueandfalse");
      }
    });
  }

  final examchapter = Map<String, String>();
  var pp;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  Widget chapter1() {
    return Column(
      children: <Widget>[
        Text(
          "Chapter 1",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CheckboxListTile(
                value: mcq1,
                onChanged: mcq1Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'MCQ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: truenandfalse1,
                onChanged: trueandfalse1Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'True&\nFalse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        truenandfalse1 == true
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                    value: trueandfalse_1,
                    items: listtrueandfalse1
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Number of true and false questions  :'),
                    onChanged: (value) {
                      setState(() {
                        trueandfalse_1 = value;
                        examchapter["chapter1trueandfalse"] = "$value";
                      });
                    }))
            : Container(),
        mcq1 == true
            ? Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "A",
                            style: TextStyle(color: Colors.white),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 55),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: DropdownButtonFormField<dynamic>(
                                  value: mcq_a1,
                                  items: list_mcq_a1
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  hint: Text('Number of question in level A :'),
                                  onChanged: (value) {
                                    setState(() {
                                      mcq_a1 = value;
                                      examchapter["chapter1mcqa"] = value;
                                    });
                                  })),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "B",
                            style: TextStyle(color: Colors.white),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 55),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: DropdownButtonFormField<dynamic>(
                                  value: mcq_b1,
                                  items: list_mcq_b1
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  hint: Text('Number of question in level B :'),
                                  onChanged: (value) {
                                    setState(() {
                                      mcq_b1 = value;
                                      examchapter["chapter1mcqb"] = value;
                                    });
                                  })),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "C",
                            style: TextStyle(color: Colors.white),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 55),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: DropdownButtonFormField<dynamic>(
                                  value: mcq_c1,
                                  items: list_mcq_c1
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  hint: Text('Number of question in level C :'),
                                  onChanged: (value) {
                                    setState(() {
                                      mcq_c1 = value;
                                      examchapter["chapter1mcqc"] = value;
                                    });
                                  })),
                          flex: 6,
                        )
                      ],
                    ),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  Widget chapter2() {
    return Column(
      children: <Widget>[
        Text(
          "Chapter 2",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CheckboxListTile(
                value: mcq2,
                onChanged: mcq2Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'MCQ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: truenandfalse2,
                onChanged: trueandfalse2Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'True&\nFalse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        truenandfalse2 == true
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                    value: trueandfalse_2,
                    items: listtrueandfalse2
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Number of true and false question  :'),
                    onChanged: (value) {
                      setState(() {
                        trueandfalse_2 = value;
                        examchapter["chapter2trueandfalse"] = "$value";
                      });
                    }))
            : Container(),
        mcq2 == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_a2,
                                items: list_mcq_a2
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of questions in level A :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_a2 = value;
                                    examchapter["chapter2mcqa"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_b2,
                                items: list_mcq_b2
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level B :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_b2 = value;
                                    examchapter["chapter2mcqb"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "C",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_c2,
                                items: list_mcq_c2
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level C :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_c2 = value;
                                    examchapter["chapter2mcqc"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  Widget chapter3() {
    return Column(
      children: <Widget>[
        Text(
          "Chapter 3",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CheckboxListTile(
                value: mcq3,
                onChanged: mcq3Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'MCQ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: truenandfalse3,
                onChanged: trueandfalse3Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'True&\nFalse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        truenandfalse3 == true
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                    value: trueandfalse_3,
                    items: listtrueandfalse3
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Number of true and false question  :'),
                    onChanged: (value) {
                      setState(() {
                        trueandfalse_3 = value;
                        examchapter["chapter3trueandfalse"] = "$value";
                      });
                    }))
            : Container(),
        mcq3 == true
            ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_a3,
                                items: list_mcq_a3
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level A :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_a3 = value;
                                    examchapter["chapter3mcqa"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_b3,
                                items: list_mcq_b3
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level B :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_b3 = value;
                                    examchapter["chapter3mcqb"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "C",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_c3,
                                items: list_mcq_c3
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level C :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_c3 = value;
                                    examchapter["chapter3mcqc"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  Widget chapter4() {
    return Column(
      children: <Widget>[
        Text(
          "Chapter 4",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CheckboxListTile(
                value: mcq4,
                onChanged: mcq4Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'MCQ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: truenandfalse4,
                onChanged: trueandfalse4Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'True&\nFalse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        truenandfalse4 == true
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                    value: trueandfalse_4,
                    items: listtrueandfalse4
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Number of true and false question  :'),
                    onChanged: (value) {
                      setState(() {
                        trueandfalse_4 = value;
                        examchapter["chapter4trueandfalse"] = "$value";
                      });
                    }))
            : Container(),
        mcq4 == true
            ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_a4,
                                items: list_mcq_a4
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level A :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_a4 = value;
                                    examchapter["chapter4mcqa"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_b4,
                                items: list_mcq_b4
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level B :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_b4 = value;
                                    examchapter["chapter4mcqb"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "C",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_c4,
                                items: list_mcq_c4
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level C :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_c4 = value;
                                    examchapter["chapter4mcqc"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  Widget chapter5() {
    return Column(
      children: <Widget>[
        Text(
          "Chapter 5",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CheckboxListTile(
                value: mcq5,
                onChanged: mcq5Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'MCQ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: truenandfalse5,
                onChanged: trueandfalse5Changed,
                controlAffinity: ListTileControlAffinity.leading,
                title: new Text(
                  'True&\nFalse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        truenandfalse5 == true
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                    value: trueandfalse_5,
                    items: listtrueandfalse5
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Number of true and false question  :'),
                    onChanged: (value) {
                      setState(() {
                        trueandfalse_5 = value;
                        examchapter["chapter5trueandfalse"] = "$value";
                      });
                    }))
            : Container(),
        mcq5 == true
            ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_a5,
                                items: list_mcq_a5
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level A :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_a5 = value;
                                    examchapter["chapter5mcqa"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_b5,
                                items: list_mcq_b5
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level B :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_b5 = value;
                                    examchapter["chapter5mcqb"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "C",
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 55),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: DropdownButtonFormField<dynamic>(
                                value: mcq_c5,
                                items: list_mcq_c5
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label.toString()),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Text('Number of question in level C :'),
                                onChanged: (value) {
                                  setState(() {
                                    mcq_c5 = value;
                                    examchapter["chapter5mcqc"] = value;
                                  });
                                })),
                        flex: 6,
                      )
                    ],
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  var b1;
  addchaptertoexam(String idexam, String chapter, String level, String type,
      String count) async {
    var url = "http://${_store.ipaddress}/app/professor.php";

    b1 = await http.post(url, body: {
      "action": "addchaptertoexam",
      "examid": idexam,
      "chapter": chapter,
      "level": level,
      "type": type,
      "count": count
    });
    print(b1.body);
  }

  var b;
  add_exam(String subject, String when, String time, Map data) async {
    var url = "http://${_store.ipaddress}/app/professor.php";
    b = await http.post(url, body: {
      "action": "add_detailsexam",
      "subject": subject,
      "when": when,
      "time": time,
      "data": data.toString()
    });
    print(b.body);
    String add = b.body;
    data["chapter1trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "1", "null", "trueandfalse", data["chapter1trueandfalse"]);
    data["chapter2trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "2", "null", "trueandfalse", data["chapter2trueandfalse"]);
    data["chapter3trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "3", "null", "trueandfalse", data["chapter3trueandfalse"]);
    data["chapter4trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "4", "null", "trueandfalse", data["chapter4trueandfalse"]);
    data["chapter5trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "5", "null", "trueandfalse", data["chapter5trueandfalse"]);
    data["chapter1mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "1", "A", "mcq", data["chapter1mcqa"]);
    data["chapter1mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "1", "B", "mcq", data["chapter1mcqb"]);
    data["chapter1mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "1", "C", "mcq", data["chapter1mcqc"]);

    data["chapter2mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "A", "mcq", data["chapter2mcqa"]);
    data["chapter2mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "B", "mcq", data["chapter2mcqb"]);
    data["chapter2mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "C", "mcq", data["chapter2mcqc"]);

    data["chapter3mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "A", "mcq", data["chapter3mcqa"]);
    data["chapter3mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "B", "mcq", data["chapter3mcqb"]);
    data["chapter3mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "C", "mcq", data["chapter3mcqc"]);

    data["chapter4mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "A", "mcq", data["chapter4mcqa"]);
    data["chapter4mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "B", "mcq", data["chapter4mcqb"]);
    data["chapter4mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "C", "mcq", data["chapter4mcqc"]);

    data["chapter5mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "A", "mcq", data["chapter5mcqa"]);
    data["chapter5mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "B", "mcq", data["chapter5mcqb"]);
    data["chapter5mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "C", "mcq", data["chapter5mcqc"]);
    Toast.Toast.show("that queation is add", context,
        duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    Navigator.pop(context);
  }

  Widget question(int chapter) {
    return Container(
        child: Column(
      children: <Widget>[
        chapter >= 1 ? chapter1() : Container(),
        chapter >= 2 ? chapter2() : Container(),
        chapter >= 3 ? chapter3() : Container(),
        chapter >= 4 ? chapter4() : Container(),
        chapter >= 5 ? chapter5() : Container(),
      ],
    ));
  }

  var date;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff254660),
              title: Text("Add Exam"),
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
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: DateTimeField(
                            format: format,
                            decoration: InputDecoration(
                              labelText: "When the exam will be",
                              hintText: "Enter when the exam will be",
                            ),
                            controller: timeofexam,
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
                            value: timevalue,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter the time';
                              } else if (value == " ") {
                                return 'Enter the time';
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
                            hint: Text('How long of your exam :'),
                            onChanged: (value) {
                              setState(() {
                                timevalue = value;
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
                            value: numbervalue,
                            validator: (value) {
                              if (value == null) {
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
                      numbervalue != null
                          ? question(int.parse(numbervalue))
                          : Container(),
                      Card(
                          color: Colors.blue,
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FlatButton(
                                onPressed: () {
                                  //database_professor().
                                  add_exam(subjectvalue, timeofexam.text,
                                      timevalue, examchapter);
                                },
                                child: Text("Done",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              ))),
                    ],
                  )),
            )));
  }
}
