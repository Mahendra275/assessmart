import 'dart:convert';
import 'dart:io';

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
import 'package:http/http.dart' as http;

//CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
//    'CSE/tpq7OnJO9Y3xuP30W42H/2021-22/QvCl4Yvoi5X40pFQ4yBH/DIP_Lab');

class CreateLab extends StatefulWidget {
  const CreateLab({Key? key}) : super(key: key);

  @override
  State<CreateLab> createState() => _CreateLabState();
}

class _CreateLabState extends State<CreateLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("View Lab"),
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
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
      'CSE/tpq7OnJO9Y3xuP30W42H/2021-22/QvCl4Yvoi5X40pFQ4yBH/DIP_Lab');
  Future<List> getData(String url) async {
    // Get docs from collection reference
    print(url);
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(url);
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  List<String> titles = [];
  Map<String, dynamic>? ch;
  String? title;
  late List alldata;
  Widget block = Container(), codeblock = Container();
  String? dept, subject, year, sem, lang = 'python', theme = 'Dark';
  Map<String, TextStyle>? theme1 = monokaiSublimeTheme;
  Map<String, String> allSources = {
    'python': "print(\"Hello World!\")",
    'cpp':
        "#include<iostream>\nusing namespace std;\nint main(){\n    cout << \"Hello World!\";\n    return 0;\n}",
    'java':
        "class Main{\n    public static void main(String[] args){\n        System.out.println(\"Hello World!\");\n    }\n}",
  };
  Mode? language = allLanguages['python'];
  String? source = "print(\"Hello World!\")";
  String? description = "Description here...";

  final _fcodecontroller = TextEditingController();
  final _titlecontroller = TextEditingController();

  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    // Instantiate the CodeController
    _codeController = CodeController(
        text: source,
        language: language,
        theme: theme1,
        params: const EditorParams(
          tabSpaces: 4,
        ));
  }

  @override
  void dispose() {
    _codeController?.dispose();
    _fcodecontroller.dispose();
    _titlecontroller.dispose();
    super.dispose();
  }

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
                    items: <String>[
                      'DIP',
                      'DIP_Lab',
                      'DAA',
                      'Python',
                      'DAA_Lab'
                    ].map<DropdownMenuItem<String>>((String value) {
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
            SizedBox(
              width: min(wth, 600),
              child: Row(children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: TextField(
                    controller: _fcodecontroller,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Teacher Id',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          String url =
                              'branch/${dept!}/year/${year!}/${subject!}';

                          alldata = await getData(url);
                          titles.clear();
                          for (Map<String, dynamic> doc in alldata) {
                            if (doc['f_code'] != null &&
                                doc['f_code'] != _fcodecontroller) {
                              titles.add(doc['title']);
                            }
                          }
                          print(titles);
                          if (titles.isNotEmpty) {
                            title = titles.first;
                            setState(() {
                              block = SizedBox(
                                width: min(wth, 600),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.tight,
                                      child: DropdownButtonFormField(
                                        value: title,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        items: titles
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Center(
                                                child: Text(value),
                                              ));
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            title = newValue!;
                                          });
                                        },
                                        onSaved: (String? newValue) {
                                          setState(() {
                                            title = newValue!;
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
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 15),
                                            primary: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              for (Map<String, dynamic> doc
                                                  in alldata) {
                                                if (doc['title'] == title) {
                                                  description =
                                                      doc['description'];
                                                  source = doc['starter_code'];
                                                  break;
                                                }
                                              }
                                              source = source!
                                                  .replaceAll("\\n", "\n");
                                              source = source!
                                                  .replaceAll("\\t", "    ");
                                            });
                                          },
                                          child: const Text('View Submissions'),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  // Retrieve the text the that user has entered by using the
                                  // TextEditingController.
                                  content: Text("NO such lab avaliable!!"),
                                );
                              },
                            );
                            setState(() {
                              block = Container();
                            });
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: Text("No such lab avaliable"),
                              );
                            },
                          );
                          setState(() {
                            block = Container();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 15),
                        primary: Colors.blue[800],
                      ),
                      child: const Text('View Created Labs'),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
    );
  }
}
