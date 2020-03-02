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
  TextEditingController Adminemail;
  TextEditingController Adminname;
  TextEditingController Adminnationalid;
  TextEditingController Adminpassword;
  String Adminemailsave, Adminpasswordsave, Adminnamesave, Adminnationalidsave;
  void initState() {
    super.initState();
    Adminemail = new TextEditingController();
    Adminname = new TextEditingController();
    Adminnationalid = new TextEditingController();
    Adminpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  login(String national, String name, String id, String password) async {
    database api = new database();
    var l =
        await api.sendtodatabase('Admin_request', national, name, id, password);
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
                          context, Adminpasswordnode, Adminnamenode);
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
                login(Adminnationalid.text, Adminname.text, Adminemail.text,
                    Adminpassword.text);
                print("cccccccccc");
              },
            ),
          ],
        ),
      ),
    );
  }
}
