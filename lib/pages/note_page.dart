import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../widgets/notes_listview.dart';

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
          Helper.navigatorPushToDetailsPage(
              context: context, title: 'Add Note');
        },
        tooltip: 'F',
        child: Icon(Icons.add),
      ),
    );
  }
}
