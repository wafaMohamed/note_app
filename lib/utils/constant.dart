import 'package:flutter/material.dart';

import '../pages/note_details_page.dart';

class Helper {
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
}
