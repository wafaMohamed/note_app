import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  String? name;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name');
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
            cursorColor: Colors.pink,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter Name",
            ),
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
            name ?? "not found",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
