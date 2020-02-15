import 'package:flutter/material.dart';
import 'package:municipality_portal/screens/Homepage.dart';
import 'package:municipality_portal/screens/Registration.dart';
import 'package:municipality_portal/screens/After_verif.dart';
import 'package:municipality_portal/screens/otp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
      ),
      initialRoute: Homepage.id,
      routes: {
        Homepage.id: (context) => Homepage(),
        Registration.id: (context) => Registration(),
        After_verif.id: (context) => After_verif(),
        otp.id: (context) => otp(),
      },
    );
  }

}

