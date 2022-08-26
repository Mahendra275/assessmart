import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/highlight.dart';
// Import the language & theme
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:highlight/src/mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CodingLab extends StatefulWidget {
  const CodingLab({Key? key}) : super(key: key);

  @override
  State<CodingLab> createState() => _CodingLabState();
}

class _CodingLabState extends State<CodingLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("Coding Lab"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: const CodeBlock(),
      )),
    );
  }
}

class CodeBlock extends StatefulWidget {
  const CodeBlock({Key? key}) : super(key: key);

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  Widget block = Container(), codeblock = Container();
  String? dept, subject, year, sem, lang = 'python', theme = 'Dark';

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width;
    //var hgt = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: min(wth, 600),
            child: Row(children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: DropdownButtonFormField(
                  value: dept,
                  borderRadius: BorderRadius.circular(8.0),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: const TextStyle(color: Colors.black),
                  hint: const Text('Select Department'),
                  items: <String>['CSE', 'ECE', 'MECH']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(value),
                        ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dept = newValue!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      dept = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: DropdownButtonFormField(
                  value: subject,
                  borderRadius: BorderRadius.circular(8.0),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: const TextStyle(color: Colors.black),
                  hint: const Text('Select Subject'),
                  items: <String>['DIP', 'DIP_Lab', 'CSE', 'Student', 'Teacher']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(
                          value,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      subject = newValue!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      subject = value;
                    });
                  },
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: min(wth, 600),
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: DropdownButtonFormField(
                      value: year,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      hint: const Text('Select Year'),
                      items: <String>['2021-22', '2022-23']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                              ),
                            ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          year = newValue!;
                        });
                      },
                      onSaved: (String? newValue) {
                        setState(() {
                          year = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: DropdownButtonFormField(
                      value: sem,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      hint: const Text('Select SEM'),
                      items: <String>['sem - 1', 'sem - 2']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(value),
                            ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          sem = newValue!;
                        });
                      },
                      onSaved: (String? newValue) {
                        setState(() {
                          sem = newValue!;
                        });
                      },
                    ),
                  ),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
