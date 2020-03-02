import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import '../Database/Database.dart';
import 'professor.dart';

class Adminsignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminsignupPage();
  }
}

class AdminsignupPage extends State<Adminsignup> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Adminemailnode = FocusNode();
  final FocusNode Adminnamenode = FocusNode();
  final FocusNode Adminnationalidnode = FocusNode();
  final FocusNode Adminpasswordnode = FocusNode();
  final FocusNode Admingradutednode = FocusNode();
  final FocusNode Adminagenode = FocusNode();
  TextEditingController Adminemail;
  TextEditingController Adminname;
  TextEditingController Admingraduted;
  TextEditingController Adminage;
  TextEditingController Adminnationalid;
  TextEditingController Adminpassword;
  String Adminemailsave,
      Adminpasswordsave,
      Admingradutedsave,
      Adminagesave,
      Adminnamesave,
      Adminnationalidsave;
  void initState() {
    super.initState();
    Adminemail = new TextEditingController();
    Adminname = new TextEditingController();
    Adminnationalid = new TextEditingController();
    Admingraduted = new TextEditingController();
    Adminage = new TextEditingController();
    Adminpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  login(String national, String name, String email, String password,
      String graduted, String age) async {
    database api = new database();
    var l = await api.sendtodatabase1('Admin', name, email, int.parse(national),
        password, graduted, int.parse(age));
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: Adminnationalid,
                    focusNode: Adminnationalidnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Adminnationalidsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Adminnationalidnode, Adminemailnode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your id",
                      hintText: "Enter your id",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your id';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Adminemail,
                    focusNode: Adminemailnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => Adminemailsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Adminemailnode, Adminpasswordnode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your Email",
                      hintText: "Enter your Email",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Adminpassword,
                    focusNode: Adminpasswordnode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Adminpasswordsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Adminpasswordnode, Admingradutednode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your Password",
                      hintText: "Enter your Password",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Admingraduted,
                    focusNode: Admingradutednode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Admingradutedsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, Admingradutednode, Adminagenode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your graduted",
                      hintText: "Enter your graduted",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your graduted';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: Adminage,
                    focusNode: Adminagenode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Adminagesave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, Adminagenode, Adminnamenode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your age",
                      hintText: "Enter your age",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: Adminname,
                    focusNode: Adminnamenode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => Adminnamesave = input,
                    onFieldSubmitted: (value) {
                      Adminnamenode.unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: "Your name",
                      hintText: "Enter your name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your name';
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text(
                  "login ",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            FlatButton(
              child: Text(
                "sign up admin",
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  login(Adminnationalid.text, Adminname.text, Adminemail.text,
                      Adminpassword.text, Admingraduted.text, Adminage.text);
                  print("cccccccccc");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
