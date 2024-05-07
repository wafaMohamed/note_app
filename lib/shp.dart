import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends StatefulWidget {
  const SharedPrefs({
    super.key,
  });

  @override
  State<SharedPrefs> createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  late SharedPreferences sharedPreferences;
  String? name;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString("name");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Local Storage App"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter Name"),
          ),
          ElevatedButton(
            onPressed: () async {
              await sharedPreferences.setString('name', nameController.text);
              name = nameController.text;
              setState(() {});
            },
            child: Text("Save"),
          ),
          Text(
            "${name ?? "NULL"}",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
