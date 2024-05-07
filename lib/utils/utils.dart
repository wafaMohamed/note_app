import 'package:flutter/material.dart';

import '../pages/note_details_page.dart';

class Utils {
  static navigatorPushToDetailsPage(
      {required String title, required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteDetailsPage(
          title: title,
        ),
      ),
    );
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
