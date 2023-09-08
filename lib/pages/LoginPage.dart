import 'package:firebase_test/MyRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_for_all/firebase_for_all.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuthForAll.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  String username = "";
  String password = "";
  void submit() async {
    if (_key.currentState!.validate()) {
      try {
        _key.currentState!.save();
        await _firebaseAuth.signInWithEmailAndPassword(
            email: username, password: password);
        print("Username: $username");
        print("Password: $password");
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed")));
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
          ),
          Image.asset(
            "assets/images/dblogo.png",
            width: 200,
            height: 200,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                              hintText: "Enter a Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (newValue) => username = newValue!,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter a Password",
                            labelText: "Password",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (newValue) => password = newValue!,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            submit();
                          },
                          child: Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
