import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/mainpageforadmin.dart';
import 'Login/choose_Login.dart';
import 'Student/mainpageforstudent.dart';
import 'professor/mainofprofessor.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('loginasadmin') == "yes") {
    runApp(Admin());
  } else if (prefs.getString('loginasprofessor') == "yes") {
    runApp(Professor());
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
        '/mainstudent': (BuildContext context) => new MainStudent(),
        '/mainforadmin': (BuildContext context) => new MainAdmin(),
        '/chooselogin': (BuildContext context) => new ChooseLogin(),
        '/mainprofessor': (BuildContext context) => new MainProfessor(),
      },
      home: ChooseLogin(),
    );
  }
}

class Admin extends StatelessWidget {
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
        '/chooselogin': (BuildContext context) => new ChooseLogin(),
        '/mainstudent': (BuildContext context) => new MainStudent(),
        '/mainforadmin': (BuildContext context) => new MainAdmin(),
        '/mainprofessor': (BuildContext context) => new MainProfessor(),
      },
      home: MainAdmin(),
    );
  }
}

class Professor extends StatelessWidget {
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
        '/chooselogin': (BuildContext context) => new ChooseLogin(),
        '/mainstudent': (BuildContext context) => new MainStudent(),
        '/mainforadmin': (BuildContext context) => new MainAdmin(),
        '/mainprofessor': (BuildContext context) => new MainProfessor(),
      },
      home: MainProfessor(),
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
        '/chooselogin': (BuildContext context) => new ChooseLogin(),
        '/mainstudent': (BuildContext context) => new MainStudent(),
        '/mainforadmin': (BuildContext context) => new MainAdmin(),
        '/mainprofessor': (BuildContext context) => new MainProfessor(),
      },
      home: MainStudent(),
    );
  }
}
