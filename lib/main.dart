import 'package:firebase_test/MyRoutes.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:firebase_test/pages/HomePage.dart';
import 'package:firebase_test/pages/LoginPage.dart';
import 'package:firebase_test/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_for_all/firebase_for_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseCoreForAll.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      firestore: true,
      auth: true,
      storage: true);
  runApp(CloudApp());
}

class CloudApp extends StatelessWidget {
  const CloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(152, 75, 10, 228),
          )),
      title: "Cloud App",
      home: StreamBuilder(
          stream: FirebaseAuthForAll.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapshot.hasData) {
              return HomePage();
            } 
            // else {
              return LoginPage();
            // } 
          }),
      routes: {
        MyRoutes().login: (context) => LoginPage(),
        MyRoutes().home: (context) => HomePage(),
      },
    );
  }
}
