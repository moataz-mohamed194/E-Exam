import 'dart:io';
import 'package:exam/Admin/add_department.dart';
import 'package:exam/Admin/mainpageforadmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String path = join('exam/lib/Database/', 'E-exam.db');
    //go to function _onCreate and create that table in it
    var mydb = await openDatabase(path, version: 5, onCreate: _onCreate);
    print(path);
    return mydb;
  }

  //to create table for admines
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE `Subject` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Name`	TEXT UNIQUE,	`department`	TEXT,	`professor`	TEXT,	`level`	TEXT,	`semester`	TEXT,`counter`	TEXT)');

    await db.execute(
        'CREATE TABLE `Department` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Name`	TEXT UNIQUE,	`whenstart`	TEXT,	`leader`	TEXT)');

    await db.execute(
        'CREATE TABLE `request` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`type`	TEXT,	`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`Password`	TEXT,	`realName`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');
    await db.execute(
        'CREATE TABLE `Admin` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`Password`	TEXT,	`realName`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');
    await db.execute(
        'CREATE TABLE `Professor` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,		`Nationalid`	INTEGER UNIQUE,	`Email`	TEXT UNIQUE,	`Password`	TEXT,	`realName`	TEXT,	`graduted`	TEXT,	`age`	INTEGER)');

    //       '  CREATE TABLE `Student` (	`ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,	`Email`	TEXT UNIQUE,	`realName`	TEXT,	`Password`	TEXT)');
  }

//that method to get the subject from database
  Future<List> get_subject() async {
    var dbclient = await db;
    return await dbclient.query("Subject");
  }

  //to get professor data
  Future<List> getadmindata() async {
    var dbclient = await db;
    return await dbclient.query("Admin");
  }

//that method to get the subject from database
  Future<int> update_subject(String name, String department, String professor,
      String level, String semester, String id) async {
    int i;
    var dbclient = await db;

    if (department != null) {
      print("ggggggggggggg");
      i = await dbclient.rawUpdate('Update Subject set '
          'department="$department"'
          ' where ID =$id ');
    }

    if (professor != null) {
      i = await dbclient.rawUpdate('Update Subject set '
          'professor="$professor"'
          ' where ID =$id ');
    }
    if (level != null) {
      i = await dbclient.rawUpdate('Update Subject set '
          'level="$level"'
          ' where ID =$id ');
    }
    if (semester != null) {
      i = await dbclient.rawUpdate('Update Subject set '
          'semester="$semester"'
          ' where ID =$id ');
    }

    return i;
  }

  //that method to add subject to database
  Future<int> add_subjecttosqlite(String name, String department,
      String professor, String level, String semester) async {
    var dbclient = await db;
    int add = await dbclient.insert('Subject', {
      'Name': '$name',
      'department': '$department',
      'professor': '$professor',
      'level': '$level',
      'semester': '$semester'
    });
    return add;
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

//that method to get the request from admin and professor
  Future<List> get_request() async {
    var dbclient = await db;
    return await dbclient.query("request");
  }

//that method to get the professor name
  Future<List> Leader_of_department() async {
    var dbclient = await db;
    return await dbclient.query("Professor", columns: ['realName']);
  }

//that method to get the department name
  Future<List> name_of_department() async {
    var dbclient = await db;
    return await dbclient.query("Department");
  }

// that method to remove the request from database when admin reject the request
  Future<int> remove(int id) async {
    var dbclient = await db;
    int delete = await dbclient.rawUpdate('DELETE FROM request where ID=$id');
    return delete;
  }

// that method when admin accept request and remove the request from database
  Future<int> accept(int nationalid, String email, String realName,
      String password, int id, String graduted, int age, String type) async {
    var dbclient = await db;
    if (type == 'Professor') {
      int add = await dbclient.insert('Professor', {
        'Nationalid': '$nationalid',
        'Email': '$email',
        'realName': '$realName',
        'Password': '$password',
        'graduted': '$graduted',
        'age': '$age'
      });
      int delete = await dbclient.rawUpdate('DELETE FROM request where ID=$id');
      print(add);

      return delete;
    } else if (type == 'Admin') {
      int add = await dbclient.insert('Admin', {
        'Nationalid': '$nationalid',
        'Email': '$email',
        'realName': '$realName',
        'Password': '$password',
        'graduted': '$graduted',
        'age': '$age'
      });
      int delete = await dbclient.rawUpdate('DELETE FROM request where ID=$id');
      print(add);
      return delete;
    }
  }

//that method to add the admin and professor request to database
  Future<int> sendtodatabase1(String table, String name, String email,
      int nationalid, String password, String graduted, int age) async {
    var dbclient = await db;
    int add = await dbclient.insert('request', {
      'type': '$table',
      'Nationalid': '$nationalid',
      'Email': '$email',
      'realName': '$name',
      'Password': '$password',
      'graduted': '$graduted',
      'age': '$age'
    });
    print(add);
    return add;
  }

  //these two to get the data from table and delete any row of it
  Future<List> get_request1() async {
    var dbclient = await db;
    return await dbclient.query("Professor");
  }

  Future<int> get_request12(int id) async {
    var dbclient = await db;
    int delete = await dbclient.rawUpdate('DELETE FROM Professor where ID=$id');
    return delete;
  }
}
