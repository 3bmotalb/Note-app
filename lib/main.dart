import 'package:course_flutter/auth/login.dart';
import 'package:course_flutter/auth/signup.dart';
import 'package:course_flutter/crud/addnote.dart';
import 'package:course_flutter/home/homepage.dart';
import 'package:course_flutter/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool? isloging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null)
    isloging = false;
  else
    isloging = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isloging == true ? HomePage() : Login(),
        // home: isloging == false ? SignUp() : HomePage(),
        routes: {
          "login": (context) => Login(),
          "signup": (context) => SignUp(),
          "homepage": (context) => HomePage(),
          "addnotes": (context) => AddNote(),
          // "testtwo": (context) => Test Two (),
        });
  }
}
