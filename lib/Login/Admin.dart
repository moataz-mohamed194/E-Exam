import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminLoginPage();
  }
}

class AdminLoginPage extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode adminidnode = FocusNode();
  final FocusNode adminpasswordnode = FocusNode();
  TextEditingController adminid;
  TextEditingController adminpassword;
  String adminidsave, adminpasswordsave;
  void initState() {
    super.initState();
    adminid = new TextEditingController();
    adminpassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  login() {}
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
                    controller: adminid,
                    focusNode: adminidnode,
                    textInputAction: TextInputAction.next,
                    onSaved: (input) => adminidsave = input,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, adminidnode, adminpasswordnode);
                    },
                    decoration: InputDecoration(
                      labelText: "Your ID",
                      hintText: "Enter your ID",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your ID';
                      } else if (value.length < 6) {
                        return 'Your ID must be longer than 6 numbers';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: adminpassword,
                    focusNode: adminpasswordnode,
                    textInputAction: TextInputAction.done,
                    onSaved: (input) => adminpasswordsave = input,
                    onFieldSubmitted: (value) {
                      adminpasswordnode.unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: "Your Password",
                      hintText: "Enter your Password",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your Password';
                      } else if (value.length < 6) {
                        return 'Your Password must be longer than 6 numbers';
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text(
                "Login admin",
              ),
              onPressed: () {
                print("cccccccccc");
              },
            ),
          ],
        ),
      ),
    );
  }
}
