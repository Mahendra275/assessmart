import 'package:assessmart/pages/attendence.dart';
import 'package:assessmart/pages/coding_lab.dart';
import 'package:assessmart/pages/register_attendence.dart';
import 'package:flutter/material.dart';
import 'package:assessmart/pages/home.dart';
import 'package:assessmart/pages/register.dart';
import 'package:assessmart/pages/login.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
