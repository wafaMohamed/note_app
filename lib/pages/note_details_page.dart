import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_feild.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage({super.key});

  static var _priorities = ['High', 'Low'];

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit App'),
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
                value: 'Low',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('on Changed Tap $valueSelectedByUser');
                  });
                },
              ),
            ),
            // fields

            CustomTextField(
              controller: titleController,
              label: 'Title',
              onChanged: (val) {},
            ),
            CustomTextField(
              controller: descriptionController,
              label: 'Description',
              onChanged: (val) {},
            ),
            // buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: 'Save',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
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
