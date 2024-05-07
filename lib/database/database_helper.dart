import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Private constructor to prevent direct instantiation
  DatabaseHelper._privateConstructor();

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database object
  static Database? _database;

  // Getter for the database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeAndOpenDB();
    return _database!;
  }

  // Table and column names
  static const String tableNote = 'note_table';
  static const String colID = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colPriority = 'priority';
  static const String colDate = 'date';

  // Initialize and open database
  static Future<Database> initializeAndOpenDB() async {
    // get directory path for both Android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notes.db');
    //open - create database at specified path
    Database openDB = await openDatabase(path, version: 1, onCreate: _createDb);
    return openDB;
  }

  // Create database schema
  static void _createDb(Database database, int newVersion) async {
    await database.execute(
        'CREATE TABLE $tableNote($colID INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  // 1-Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;
    // the same but the difference is that we use query instead of rawQuery(SQL statement)
    var result = await db.query(tableNote, orderBy: '$colPriority ASC');
    return result;
    // var result = await db.rawQuery('SELECT * FROM $tableNote order by $colPriority ASC');
  }
}
