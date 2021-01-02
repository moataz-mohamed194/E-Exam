import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/mainpageforadmin.dart';
import 'Login/choose_Login.dart';
import 'Student/mainpageforstudent.dart';
import 'language/AppLanguage.dart';
import 'language/Translation.dart';
import 'professor/mainofprofessor.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('loginasadmin') == "yes") {
    runApp( Admin());
  } else if (prefs.getString('loginasprofessor') == "yes") {
    runApp( Professor());
  } else if (prefs.getString('loginasstudent') == "yes") {
    runApp( Student());
  } else {
    runApp( MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLanguage());

    return GetMaterialApp(
        title: 'E-exam',
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
        translations: Translation(),
        locale: Locale(controller.appLocale),
        fallbackLocale: Locale(controller.appLocale),
    );
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLanguage());

    return GetMaterialApp(
        title: 'E-exam',
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
      translations: Translation(),
      locale: Locale(controller.appLocale),
      fallbackLocale: Locale(controller.appLocale),
      );
  }
}

class Professor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLanguage());

    return  GetMaterialApp(
          title: 'E-exam',
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
          translations: Translation(),
          locale: Locale(controller.appLocale),
          fallbackLocale: Locale(controller.appLocale),
        );
  }
}

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLanguage());

    return GetMaterialApp(
          title: 'E-exam',
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
      translations: Translation(),
      locale: Locale(controller.appLocale),
      fallbackLocale: Locale(controller.appLocale),
        );
  }
}
