import 'dart:async' as prefix0;
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

    await db.execute(
        'CREATE TABLE `examdetails` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`subject`	TEXT,	`whenstart`	TEXT,	`time`	TEXT)');
    await db.execute(
        'CREATE TABLE `examchapter` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`examid`	INTEGER ,	`chapter`	INTEGER ,	`type`	TEXT,	`level`	TEXT,	`count`	TEXT)');
  }

  Future<int> addchaptertoexam(String idexam, String chapter, String level,
      String type, String count) async {
    var dbclient = await db;
    int addtwo = await dbclient.insert('examchapter', {
      'examid': '$idexam',
      'chapter': chapter,
      'level': level,
      'type': type,
      'count': count
    });
    //  print("object$addtwo");
    return addtwo;
  }

  Future<int> add_exam(
      String subject, String when, String time, Map data) async {
    var dbclient = await db;
    //_onCreate(dbclient, 0);
    int add = await dbclient.insert('examdetails',
        {'subject': '$subject', 'whenstart': '$when', 'time': '$time'});
    data["chapter1trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "1", "null", "trueandfalse", data["chapter1trueandfalse"]);
    data["chapter2trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "2", "null", "trueandfalse", data["chapter2trueandfalse"]);
    data["chapter3trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "3", "null", "trueandfalse", data["chapter3trueandfalse"]);
    data["chapter4trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "4", "null", "trueandfalse", data["chapter4trueandfalse"]);
    data["chapter5trueandfalse"] == null
        ? print("time")
        : addchaptertoexam(
            "$add", "5", "null", "trueandfalse", data["chapter5trueandfalse"]);
    data["chapter1mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "1", "A", "mcq", data["chapter1mcqa"]);
    data["chapter1mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "1", "B", "mcq", data["chapter1mcqb"]);
    data["chapter1mcqc"] == null
        ? print("time")
        : addchaptertoexam("1", "1", "C", "mcq", data["chapter1mcqc"]);

    data["chapter2mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "A", "mcq", data["chapter2mcqa"]);
    data["chapter2mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "B", "mcq", data["chapter2mcqb"]);
    data["chapter2mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "2", "C", "mcq", data["chapter2mcqc"]);

    data["chapter3mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "A", "mcq", data["chapter3mcqa"]);
    data["chapter3mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "B", "mcq", data["chapter3mcqb"]);
    data["chapter3mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "3", "C", "mcq", data["chapter3mcqc"]);

    data["chapter4mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "A", "mcq", data["chapter4mcqa"]);
    data["chapter4mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "B", "mcq", data["chapter4mcqb"]);
    data["chapter4mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "4", "C", "mcq", data["chapter4mcqc"]);

    data["chapter5mcqa"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "A", "mcq", data["chapter5mcqa"]);
    data["chapter5mcqb"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "B", "mcq", data["chapter5mcqb"]);
    data["chapter5mcqc"] == null
        ? print("time")
        : addchaptertoexam("$add", "5", "C", "mcq", data["chapter5mcqc"]);
    print("objectobjectobjectobject");
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
