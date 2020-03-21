import 'dart:io';
import 'package:exam/Admin/add_department.dart';
import 'package:exam/professor/getchapter.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class database_professor {
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
        'CREATE TABLE `Subject` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Name`	TEXT UNIQUE,	`department`	TEXT,	`professor`	TEXT,	`level`	TEXT,	`semester`	TEXT,`counter`	TEXT)');
    await db.execute(
        'CREATE TABLE `Chapter` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT,	`subjectname`	TEXT,	`chaptername`	TEXT);');
    await db.execute(
        'CREATE TABLE `queastion_mcq` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Question`	TEXT UNIQUE,	`subject`	TEXT,	`numberofchapter`	TEXT,	`level`	TEXT,	`answer1`	TEXT,	`answer2`	TEXT,	`answer3`	TEXT,	`answer4`	TEXT,	`correctanswer`	TEXT,	`bank`	TEXT)');
    await db.execute(
        'CREATE TABLE `queastion_true_and_false` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Question`	TEXT UNIQUE,	`subject`	TEXT,	`numberofchapter`	TEXT,	`correctanswer`	TEXT,	`bank`	TEXT)');

//    await db.execute(
    //      'CREATE TABLE `Professor` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`Password`	TEXT,	`realName`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');
  }

  //to remove mcq question from database
  Future<int> remove_mcq_question(int id) async {
    var dbclient = await db;
    int delete =
        await dbclient.rawUpdate('DELETE FROM queastion_mcq where ID=$id');
    return delete;
  }

  //to remove the true&false question from the database
  Future<int> remove_true_and_false_question(int id) async {
    var dbclient = await db;
    int delete = await dbclient
        .rawUpdate('DELETE FROM queastion_true_and_false where ID=$id');
    return delete;
  }

  //to add mcq question from database and if the checkbox is checked add that question and be in a bank
  Future<int> add_question_mcq_tosqlite(
      String question,
      String subject,
      String numberofchapter,
      String level,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      String correctanswer,
      String bank) async {
    var dbclient = await db;
    int add = await dbclient.insert('queastion_mcq', {
      'Question': '$question',
      'subject': '$subject',
      'numberofchapter': '$numberofchapter',
      'level': '$level',
      'answer1': '$answer1',
      'answer2': '$answer2',
      'answer3': '$answer3',
      'answer4': '$answer4',
      'correctanswer': '$correctanswer',
      'bank': '$bank'
    });
    return add;
  }

  //to add true&false question from database and if checkbox is checked add that question and be in bank
  Future<int> add_question_true_and_false_tosqlite(
      String question,
      String subject,
      String numberofchapter,
      String correctanswer,
      String bank) async {
    var dbclient = await db;
    //_onCreate(dbclient, 2);

    int add = await dbclient.insert('queastion_true_and_false', {
      'Question': '$question',
      'subject': '$subject',
      'numberofchapter': '$numberofchapter',
      'correctanswer': '$correctanswer',
      'bank': '$bank'
    });
    return add;
  }

  //to add chapter to database
  Future<int> add_chapter_tosqlite(
      String subjectname, String chaptername) async {
    var dbclient = await db;
    int add = await dbclient.insert('Chapter', {
      'subjectname': '$subjectname',
      'chaptername': '$chaptername',
    });
    int count = Sqflite.firstIntValue(await dbclient.rawQuery(
        'SELECT COUNT(*) FROM Chapter WHERE subjectname="$subjectname"'));
    await dbclient.rawUpdate('Update Subject set '
        'counter="$count"'
        ' where Name="$subjectname" ');
    return count;
  }

  //to remove the chapter for subject from database
  Future<int> remove_chapter_tosqlite(String subjectname, int id) async {
    var dbclient = await db;
    int delete = await dbclient.rawUpdate('DELETE FROM Chapter where ID=$id');

    int count = Sqflite.firstIntValue(await dbclient.rawQuery(
        'SELECT COUNT(*) FROM Chapter WHERE subjectname="$subjectname"'));
    await dbclient.rawUpdate('Update Subject set '
        'counter="$count"'
        ' where Name="$subjectname" ');

    return count;
  }

  //to get mcq questions
  Future<List> get_the_queation_mcq() async {
    var dbclient = await db;
    return await dbclient.query("queastion_mcq");
  }

  //to get professor data
  Future<List> getprofessordata() async {
    var dbclient = await db;
    return await dbclient.query("Professor");
  }

  //to get the chapter
  Future<List> getchapter() async {
    var dbclient = await db;
    return await dbclient.query("Chapter");
  }

  //to get true&false queations
  Future<List> get_the_queationtrue_and_false() async {
    var dbclient = await db;
    return await dbclient.query("queastion_true_and_false");
  }

//to get the subjects
  Future<List> get_subject() async {
    var dbclient = await db;
    return await dbclient.query("Subject");
  }

//to add the department to database
  Future<int> add_departmenttosqlite(
      String name, String whenstart, String leader) async {
    var dbclient = await db;

    int add = await dbclient.insert('Department',
        {'Name': '$name', 'whenstart': '$whenstart', 'leader': '$leader'});
    return add;
  }

//to check the email and password in professor login
  Future<List> check_your_email_and_password(
      String table_name, String emailadmin) async {
    var dbclient = await db;
    return await dbclient.query("$table_name", where: 'Email="$emailadmin"');
  }

//to get the subjects from database
  Future<List> get_the_subject(String name) async {
    var dbclient = await db;
    return await dbclient.query("Subject", where: 'professor="$name"');
  }
}
