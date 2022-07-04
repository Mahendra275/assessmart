import 'package:assessmart/pages/attendence.dart';
import 'package:assessmart/pages/coding_lab.dart';
import 'package:assessmart/pages/register_attendence.dart';
import 'package:flutter/material.dart';
import 'package:assessmart/pages/home.dart';
import 'package:assessmart/pages/register.dart';
import 'package:assessmart/pages/login.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const Home(),
        '/home': (context) => const Home(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/coding_lab': (context) => const CodingLab(),
        '/attendence': (context) => const Attendence(),
        '/register_attendence': (context) => const RegisterAttendence(),
      }));
}
