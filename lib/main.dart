import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/Screens/login.dart';
import 'package:firstapp/Screens/mainscreen.dart';
import 'package:firstapp/Screens/register.dart';
import 'package:flutter/material.dart';

void main() async {
  // these 2 lines
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  final Future<FirebaseApp> _Initialization = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: _Initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("errer");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return conhome();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class conhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mainscreen(),
    );
  }
}
