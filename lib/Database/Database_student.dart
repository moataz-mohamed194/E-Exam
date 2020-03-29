import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Databasestudent {
  static Database _db;
  //to check database is created
  Future<Database> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else if (_db != null) {
      return _db;
    }
  }

  initialDB() async {
    //here start your path from the beginning of the app
    Directory docDirect = await getApplicationDocumentsDirectory();
    // the name of database is exam.db
    String path = join('exam/lib/Database/', 'E-exam.db');
    //go to function _onCreate and create that table in it
    var mydb = await openDatabase(path, version: 5, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE `Student` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`Nationalid`	INTEGER UNIQUE,	`Collageid`	INTEGER UNIQUE,	`name`	TEXT,	`password`	TEXT,	`level`	TEXT,	`department`	TEXT)');
  }

  Future<List> getdepartment() async {
    var dbclient = await db;
    return await dbclient.query("Department");
  }

  Future<List> getstudentsubject(String level) async {
    var dbclient = await db;
    return await dbclient.query("Subject", where: 'level="$level"');
  }

  Future<List> mcqexam() async {
    var dbclient = await db;
    return await dbclient.query("queastion_mcq");
  }

  Future<List> trueandfalseexam() async {
    var dbclient = await db;
    return await dbclient.query("queastion_true_and_false");
  }

  //to get true&false queations
  Future<List> getthequeationtrueandfalse() async {
    var dbclient = await db;
    return await dbclient.query("queastion_true_and_false",
        where: 'bank="true"');
  }

  //to get mcq questions
  Future<List> getthequeationmcq() async {
    var dbclient = await db;
    return await dbclient.query("queastion_mcq", where: 'bank="true"');
  }

  Future<int> signupstudent(String nationalid, String collageid, String name,
      String password, String level, String department) async {
    var dbclient = await db;
    //  _onCreate(dbclient, 0);
    int add = await dbclient.insert('Student', {
      'Nationalid': '$nationalid',
      'Collageid': '$collageid',
      'name': '$name',
      'password': '$password',
      'level': '$level',
      'department': '$department'
    });
    return add;
  }

  Future<List> checkyouridandpassword(String studentid) async {
    var dbclient = await db;
    return await dbclient.query("Student", where: 'Collageid=$studentid');
  }
}
