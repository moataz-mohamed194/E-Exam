import 'dart:io';
import 'package:exam/Admin/add_department.dart';
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
    print(path);
    return mydb;
  }

  //to create table for admines
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE `Subject` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Name`	TEXT UNIQUE,	`department`	TEXT,	`professor`	TEXT,	`level`	TEXT,	`semester`	TEXT)');

    await db.execute(
        'CREATE TABLE `Professor` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`Password`	TEXT,	`realName`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');
  }

//that method to get the subject from database
  Future<List> get_subject() async {
    var dbclient = await db;
    return await dbclient.query("Subject");
  }

//that method to get the subject from database
  Future<int> update_subject(String name, String department, String professor,
      String level, String semester, int id) async {
    var dbclient = await db;
    //return await dbclient.rawUpdate(
    //  "Update 'Subject' Name=$name , department=$department,professor=$professor,level=$level,semester=$semester set where ID=$id ");
    return await dbclient
        .rawUpdate("Update Subject set 'Name=m'   where ID=1 ");
    // return await dbclient.update('Subject', 'Name=m', where: 'ID=1');
  }

//that method to add department data to database
  Future<int> add_departmenttosqlite(
      String name, String whenstart, String leader) async {
    var dbclient = await db;

    int add = await dbclient.insert('Department',
        {'Name': '$name', 'whenstart': '$whenstart', 'leader': '$leader'});
    print(add);
    return add;
  }

//that method to check the email and password of admin
  Future<List> check_your_email_and_password(
      String table_name, String emailadmin) async {
    var dbclient = await db;
    return await dbclient.query("$table_name", where: 'Email="$emailadmin"');
  }

//that method to get the professor name
  Future<List> get_the_subject(String name) async {
    var dbclient = await db;
    return await dbclient.query("Subject", where: 'professor="$name"');
  }
}
