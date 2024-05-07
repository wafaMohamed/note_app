import 'package:flutter/material.dart';

import '../utils/utils.dart';

class NotesListview extends StatelessWidget {
  const NotesListview({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.headlineLarge!;
    final int count = 0;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        elevation: 0,
        child: ListTile(
          onTap: () {
            debugPrint('ListTile Tapped');
            Utils.navigatorPushToDetailsPage(
                context: context, title: 'Edit Note');
          },
          title: Text('title $index', style: titleStyle),
          subtitle: Text('subtitle $index'),
          trailing: const Icon(
            Icons.delete,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
