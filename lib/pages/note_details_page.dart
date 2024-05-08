import 'package:flutter/material.dart';
import 'package:note_app/database/database_helper.dart';
import 'package:note_app/model/note_model.dart';

import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_feild.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage({
    super.key,
    required this.title,
    required this.note,
  });

  final String title;
  final Note note;
  static final List<String> _priorities = ['High', 'Low'];

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.instance;
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleLarge;

    void updatePriorityAsInt(String value) {
      switch (value) {
        case 'High':
          widget.note.priority = 1;
          break;
        case 'Low':
          widget.note.priority = 2;
          break;
      }
    }

    String updatePriorityAsString(int value) {
      late String priority;
      switch (value) {
        case 1:
          priority = NoteDetailsPage._priorities[0]; // High
          break;
        case 2:
          priority = NoteDetailsPage._priorities[1]; // Low
          break;
      }
      return priority;
    }

    void updateNoteTitle() {
      widget.note.title = titleController.text;
    }

    void updateDescription() {
      widget.note.description = descriptionController.text;
    }

    void saveDataToDB() async {
      Navigator.pop(context, true);
      widget.note.dateTime = DateTime.now();
      // update operation
      var result = await databaseHelper.updateNote(widget.note);
      if (result != 0) {
        // Success
        Utils.showSnackBar(
          context: context,
          message: 'Note Updated Successfully',
          backgroundColor: Colors.green,
        );
      } else {
        // Failure
        Utils.showSnackBar(
          context: context,
          message: 'Error Occurred while updating note',
          backgroundColor: Colors.red,
        );
      }
      // Insert Operation if it's null // await databaseHelper.insertNote(widget.note);
    }

    void delete() async {
      Navigator.pop(context, true);
      // case1: user want to delete the new note from details page
      if (widget.note.id != null) {
        int result = await databaseHelper.deleteNote(widget.note.id);
        if (result != 0) {
          // Success
          Utils.showSnackBar(
            context: context,
            message: 'Note Deleted Successfully',
            backgroundColor: Colors.green,
          );
        } else {
          // Failure
          Utils.showSnackBar(
            context: context,
            message: 'Error Occurred while deleting note',
            backgroundColor: Colors.red,
          );
        }
      }
      // case2: user want to delete the old note from Note page
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                items:
                    NoteDetailsPage._priorities.map((String dropDownMenuItem) {
                  return DropdownMenuItem(
                    value: dropDownMenuItem,
                    child: Text(dropDownMenuItem),
                  );
                }).toList(),
                style: textStyle,
                value: updatePriorityAsString(widget.note.priority),
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('on Changed Tap $valueSelectedByUser');
                    updatePriorityAsInt(valueSelectedByUser.toString());
                  });
                },
              ),
            ),
            // fields
            CustomTextField(
              controller: titleController,
              label: 'Title',
              onChanged: (val) {
                updateNoteTitle();
              },
            ),
            CustomTextField(
              controller: descriptionController,
              label: 'Description',
              onChanged: (val) {
                updateDescription();
              },
            ),
            // buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      saveDataToDB();
                    },
                    text: 'Save',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      delete();
                    },
                    text: 'Delete',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
