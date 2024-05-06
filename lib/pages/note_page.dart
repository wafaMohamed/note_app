import 'package:flutter/material.dart';

import '../widgets/notes_listview.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: const NotesListview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'F',
        child: Icon(Icons.add),
      ),
    );
  }
}
