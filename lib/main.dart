import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/homepage.dart';
import 'pages/program_home.dart';
import 'pages/signUp.dart';
void main() {
  runApp(ExcelerateApp());
}

class ExcelerateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage(),
        '/program': (context) => ProgramHome(),
      },
    );
  }
}
