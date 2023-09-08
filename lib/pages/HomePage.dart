import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_for_all/firebase_for_all.dart';

final _firebaseF = FirestoreForAll.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<FormState>();

  String data1 = "";
  String data2 = "";
  String data3 = "";

  void getData() async {
    print(FirebaseAuthForAll.instance.currentUser!.uid);
    final Data = await _firebaseF
        .collection("Data")
        .orderBy('Data1', descending: true)
        .get();
    for (var i in Data.docs) {
      print(i.data());
    }
  }

  void submit() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print(data1);
      print(data2);
      print(data3);
      await _firebaseF.collection("Data").add({
        "Data1": data1,
        "Data2": data2,
        "Data3": data3,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              final _firebase = FirebaseAuthForAll.instance.signOut();
              print("test");
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.tertiary,
            child: Container(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                  "Opera Project Management Consultants Privated Limited",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Welcome to Home Page"),
              ]),
              width: 1920,
              height: 200,
            ),
          ),
          Expanded(
              child: Container(
            width: 1920,
            child: Card(
              color: Colors.blue,
              child: Column(
                children: [
                  Center(
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter data 1",
                                labelText: "Enter Data 1"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Data 1";
                              }
                              return null;
                            },
                            onSaved: (newValue) => data1 = newValue!,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter data 2",
                                labelText: "Enter Data 2"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Data 1";
                              }
                              return null;
                            },
                            onSaved: (newValue) => data2 = newValue!,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter data 3",
                                labelText: "Enter Data 3"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Data 1";
                              }
                              return null;
                            },
                            onSaved: (newValue) => data3 = newValue!,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () => submit(), child: Text("Submit"))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("Get Data"),
                    onPressed: () => getData(),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
