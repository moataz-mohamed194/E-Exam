import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class database {
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
    String path = join('exam/', 'exam.db');
    //go to function _onCreate and create that table in it
    var mydb = await openDatabase(path, version: 5, onCreate: _onCreate);
    print(path);
    return mydb;
  }

  //to create table for admines
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE `Professor_request` (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT,	`Nationalid`	INTEGER UNIQUE,	`realName`	TEXT,	`Password`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');
    await db.execute(
        'CREATE TABLE `Admin_request` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`realName`	TEXT,	`Password`	TEXT)');
    await db.execute(
        'CREATE TABLE `Professor` (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT,	`Nationalid`	INTEGER UNIQUE,	`realName`	TEXT,	`Password`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');

    await db.execute(
        'CREATE TABLE `Admin` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`realName`	TEXT,	`Password`	TEXT)');
    await db.execute(
        '  CREATE TABLE `Student` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Email`	TEXT UNIQUE,	`realName`	TEXT,	`Password`	TEXT)');
  }

  Future<int> sendtodatabase(String table, String id, String name, String email,
      String password) async {
    var dbclient = await db;
    // _onCreate(_db, 0);
    int add = await dbclient.insert('$table', {
      'Nationalid': int.parse(id),
      'Email': '$email',
      'realName': '$name',
      'Password': '$password'
    });
    print(add);
    return add;
  }

  Future<List> check_your_email_and_password(
      String table_name, String emailadmin) async {
    var dbclient = await db;
    return await dbclient.query("$table_name", where: 'Email="$emailadmin"');
  }

  Future<List> get_request() async {
    var dbclient = await db;
    return await dbclient.query("Admin_request");
  }

  Future<int> accept(int nationalid, String email, String realName,
      String password, int id) async {
    var dbclient = await db;
    //_onCreate(_db, 0);
    int delete =
        await dbclient.rawUpdate('DELETE FROM Admin_request where ID=$id');
    int add = await dbclient.insert('Admin', {
      'Nationalid': '$nationalid',
      'Email': '$email',
      'realName': '$realName',
      'Password': '$password',
    });
    print(add);
    return delete;
  }

  Future<int> sendtodatabase1(String table, String name, int nationalid,
      String password, String graduted, int age) async {
    var dbclient = await db;
    //_onCreate(_db, 0);
    int add = await dbclient.insert(table, {
      'Nationalid': '$nationalid',
      'realName': '$name',
      'Password': '$password',
      'graduted': '$graduted',
      'age': '$age'
    });
    print(add);
    return add;
  }
}
