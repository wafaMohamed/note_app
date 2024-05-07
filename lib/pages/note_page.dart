import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/note_model.dart';
import '../utils/utils.dart';
import '../widgets/notes_listview.dart';

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
          backgroundColor: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: const NotesListview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigatorPushToDetailsPage(context: context, title: 'Add Note');
        },
        tooltip: 'F',
        child: const Icon(Icons.add),
      ),
    );
  }
}
