import 'package:flutter/material.dart';

import 'Login/choose_Login.dart';
import 'Login/student_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Chooselogin(),
    );
  }
}
