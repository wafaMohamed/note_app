import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

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

  // 1- Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;
    // the same but the difference is that we use query instead of rawQuery(SQL statement)
    var result = await db.query(tableNote, orderBy: '$colPriority ASC');
    return result;
    // var result = await db.rawQuery('SELECT * FROM $tableNote order by $colPriority ASC');
  }

  // 2- Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await database;
    // toMap cause the sqlite deals with map objects
    int result = await db.insert(tableNote, note.toMap());
    return result;
  }

  // 3- update Operation: Update a Note object to database
  Future<int> updateNote(Note note) async {
    Database db = await database;
    var result = await db.update(tableNote, note.toMap(),
        // where to update the note (column)
        where: '$colID = ?',
        whereArgs: [note.id]);
    return result;
  }

// 4- delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    Database db = await database;
    var result =
        await db.delete(tableNote, where: '$colID = ?', whereArgs: [id]);
    return result;
  }

  // get number of (records) Note objects in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableNote');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  // Get the Map List  into ((note list))
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = <Note>[];
    // For loop to create a 'Note List' from a 'Note Map List'}
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
