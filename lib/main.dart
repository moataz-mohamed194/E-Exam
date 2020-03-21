import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Admin/add_department.dart';
import 'Admin/add_subject.dart';
import 'Admin/get_subject.dart';
import 'Admin/mainpageforadmin.dart';
import 'Database/Database_admin.dart';
import 'Login/choose_Login.dart';
import 'Login/student_login.dart';
import 'Student/mainpageforstudent.dart';
import 'cleandata.dart';
import 'professor/mainofprofessor.dart';

Future main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('loginasadmin') == "yes") {
    runApp(admin());
  } else if (prefs.getString('loginasprofessor') == "yes") {
    runApp(professor());
  } else if (prefs.getString('loginasstudent') == "yes") {
    runApp(Student());
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Bellota',
      ),
      routes: <String, WidgetBuilder>{
        '/mainstudent': (BuildContext context) => new mainstudent(),
        '/mainforadmin': (BuildContext context) => new mainadmin(),
        '/chooselogin': (BuildContext context) => new Chooselogin(),
        '/mainprofessor': (BuildContext context) => new mainprofessor(),
      },
      home: Chooselogin(), //clean(), //Chooselogin(),
    );
  }
}

class admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Bellota',
      ),
      routes: <String, WidgetBuilder>{
        '/chooselogin': (BuildContext context) => new Chooselogin(),
        '/mainstudent': (BuildContext context) => new mainstudent(),
        '/mainforadmin': (BuildContext context) => new mainadmin(),
        '/mainprofessor': (BuildContext context) => new mainprofessor(),
      },
      home: mainadmin(),
    );
  }
}

class professor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Bellota',
      ),
      routes: <String, WidgetBuilder>{
        '/chooselogin': (BuildContext context) => new Chooselogin(),
        '/mainstudent': (BuildContext context) => new mainstudent(),
        '/mainforadmin': (BuildContext context) => new mainadmin(),
        '/mainprofessor': (BuildContext context) => new mainprofessor(),
      },
      home: mainprofessor(),
    );
  }
}

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Bellota',
      ),
      routes: <String, WidgetBuilder>{
        '/chooselogin': (BuildContext context) => new Chooselogin(),
        '/mainstudent': (BuildContext context) => new mainstudent(),
        '/mainforadmin': (BuildContext context) => new mainadmin(),
        '/mainprofessor': (BuildContext context) => new mainprofessor(),
      },
      home: mainstudent(),
    );
  }
}
