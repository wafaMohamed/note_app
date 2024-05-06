import 'package:flutter/material.dart';

import '../widgets/notes_listview.dart';
import 'note_details_page.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: const NotesListview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NoteDetailsPage(),
            ),
          );
        },
        tooltip: 'F',
        child: Icon(Icons.add),
      ),
    );
  }
}
