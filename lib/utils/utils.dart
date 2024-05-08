import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';

import '../pages/note_details_page.dart';

class Utils {
  static navigatorPushToDetailsPage(
      {required String title,
      required BuildContext context,
      Function? updateListView, // callback function

      required Note note}) async {
    bool value = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteDetailsPage(title: title, note: note),
      ),
    );
    if (value == true && updateListView != null) {
      updateListView();
    }
  }

  static showSnackBar(
      {required String message,
      required BuildContext context,
      required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
    ));
  }
}
