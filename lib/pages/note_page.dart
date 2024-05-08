import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/note_model.dart';
import '../utils/utils.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Note>? noteList;

  int count = 0;

  // return color based on priority

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.pink;
        break;
      case 2:
        return Colors.grey;
        break;
      default:
        return Colors.grey;
    }
  }

  // return color based on priority
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
        break;
      case 2:
        return const Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return const Icon(Icons.keyboard_arrow_right);
    }
  }

  void deleteList(Note note, BuildContext context) async {
    int result = await databaseHelper.deleteNote(note.id);
    // notification
    if (result != 0) {
      Utils.showSnackBar(
        context: context,
        message: 'Note Deleted Successfully',
        backgroundColor: Colors.green,
      );
      updateListVew();
    }
  }

  void updateListVew() {
    final Future<Database> dbFuture = DatabaseHelper.initializeAndOpenDB();
    dbFuture.then((Database database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((List<Note> val) {
        setState(() {
          noteList = val;
          count = val.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.headlineLarge!;
    final int count = 0;
    if (noteList == null) {
      noteList = <Note>[];
      updateListVew();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          elevation: 0,
          child: ListTile(
            onTap: () {
              debugPrint('ListTile Tapped');
              Utils.navigatorPushToDetailsPage(
                  context: context,
                  title: 'Edit Note',
                  note: noteList![index],
                  updateListView: updateListVew);
            },
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList![index].priority),
              child: getPriorityIcon(noteList![index].priority),
            ),
            title: Text(noteList![index].title, style: titleStyle),
            subtitle: Text(noteList![index].dateTime.toIso8601String()),
            trailing: GestureDetector(
              onTap: () {
                deleteList(noteList![index], context);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigatorPushToDetailsPage(
              context: context,
              title: 'Add Note',
              note: Note('New Note', 2, DateTime.now()),
              updateListView: updateListVew);
        },
        tooltip: 'F',
        child: const Icon(Icons.add),
      ),
    );
  }
}
