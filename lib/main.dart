import 'package:flutter/material.dart';

import 'Admin/add_department.dart';
import 'Admin/add_subject.dart';
import 'Admin/mainpageforadmin.dart';
import 'Admin/request.dart';
import 'Database/Database.dart';
import 'Login/choose_Login.dart';
import 'Login/student_login.dart';

Future main() async {
  /*database bb = new database();
  var l = await bb.create();
  print(l);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/mainforadmin': (BuildContext context) => new mainadmin(),
      },
      home: add_subject(),
    );
  }
}
