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
        backgroundColor: Colors.teal,
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

  @override
  void dispose() {
    _fcodecontroller.dispose();
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
                      'DAA_Lab',
                      'Python'
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
                                          child: const Text('View'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
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
                                            primary: Colors.purple,
                                          ),
                                          onPressed: () async {
                                            User? user = FirebaseAuth
                                                .instance.currentUser;
                                            String? userid = user!.uid;

                                            CollectionReference _collectionRef =
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'branch/${dept!}/year/${year!}/${subject!}/${title!}/submissions');
                                            final docRef = _collectionRef
                                                .doc("submission");
                                            String? pcode = source;
                                            await docRef.get().then(
                                              (DocumentSnapshot doc) {
                                                final data = doc.data()
                                                    as Map<String, dynamic>;
                                                pcode = data[userid];
                                              },
                                              onError: (e) => print(
                                                  "Error getting document: $e"),
                                            );
                                            setState(() {
                                              source = pcode;
                                              source = source!
                                                  .replaceAll("\\n", "\n");
                                              source = source!
                                                  .replaceAll("\\t", "    ");
                                            });
                                          },
                                          child: const Text('Load'),
                                        ),
                                      ),
                                    )
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
                        primary: Colors.grey,
                      ),
                      child: const Text('View Created Lab'),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            block,
            const SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: EditableText(
                    minLines: 3,
                    maxLines: 5,
                    controller: TextEditingController(text: description),
                    focusNode: FocusNode(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                    ),
                    cursorColor: Colors.indigo,
                    backgroundCursorColor: Colors.lime),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        const Text(
                          'Language',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          value: lang,
                          borderRadius: BorderRadius.circular(8.0),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.black26,
                          ),
                          items: <String>['python', 'cpp', 'java'].map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              lang = newValue;
                              language = allLanguages[lang];
                              source = allSources[lang];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Text(
                              'Theme',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton(
                              value: theme,
                              borderRadius: BorderRadius.circular(8.0),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black26,
                              ),
                              items: <String>['Dark', 'Light'].map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  theme = newValue!;
                                  if (theme == 'Dark') {
                                    theme1 = monokaiSublimeTheme;
                                  } else {
                                    theme1 = vsTheme;
                                  }
                                });
                              },
                            ),
                          ]),
                    ]),
              ),
            ),
            CodeEditor(
              language: language,
              theme: theme1,
              source: source,
              lab: title,
              subject: subject,
              branch: dept,
              year: year,
              key: UniqueKey(),
            ),
          ]),
    );
  }
}

class CodeEditor extends StatefulWidget {
  const CodeEditor(
      {required this.language,
      this.theme,
      this.source,
      this.lab,
      this.subject,
      this.branch,
      this.year,
      Key? key})
      : super(key: key);
  final Mode? language;
  final Map<String, TextStyle>? theme;
  final String? source;
  final String? lab, branch, year, subject;
  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Instantiate the CodeController
    _codeController = CodeController(
        text: widget.source,
        language: widget.language,
        theme: widget.theme,
        params: const EditorParams(
          tabSpaces: 4,
        ));
  }

  @override
  void dispose() {
    _codeController?.dispose();
    _inputController.dispose();
    super.dispose();
  }

  //String url = 'http://127.0.0.1:5000/run?';
  Future run_code(url) async {
    http.Response Response = await http.get(url);
    return Response.body;
  }

  List<String> images = [], image_names = [];
  double fontsize = 14;
  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      const SizedBox(
        height: 8,
      ),
      CodeField(
        controller: _codeController!,
        textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: fontsize),
        minLines: 18,
        maxLines: 20,
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
            child: SizedBox(
              height: 30,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  String url =
                      'branch/${widget.branch!}/year/${widget.year!}/${widget.subject!}/${widget.lab}/submissions';
                  User? user = FirebaseAuth.instance.currentUser;
                  String? userid = user!.uid;
                  FirebaseFirestore.instance
                      .collection(url)
                      .doc('submission')
                      .set({userid: _codeController!.text},
                          SetOptions(merge: true));
                },
                child: const Text('Save'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
            child: SizedBox(
              height: 30,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                onPressed: () async {
                  String? code = _codeController!.text;
                  String? input = _inputController.text;
                  code = code.replaceAll('·', ' ');
                  User? user = FirebaseAuth.instance.currentUser;
                  String? idno;
                  print(user!.email);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: user.email)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      idno = element['userId'];
                    });
                  });
                  print(idno);
                  Uri url = Uri.https(
                      'IdealAutomaticGigabyte.n170275smahendr.repl.co', 'run', {
                    'code': code,
                    'stdin': input,
                    'user': idno,
                  });
                  // url += '?code=$code&stdin=$input';
                  var output = await run_code(url);
                  output = jsonDecode(output);
                  //print(output);
                  setState(() {
                    _outputController.text =
                        output['stdout'] + output['stderr'];
                    images.clear();
                    for (var img in output['images']) {
                      images.add(img);
                    }
                    image_names.clear();
                    for (var name in output['image_names']) {
                      image_names.add(name);
                    }
                  });
                },
                child: const Text('Run'),
              ),
            ),
          ),
        ],
      ),
      Flex(
        direction: wth > 600 ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "INPUT",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: wth > 600 ? wth * 0.4 : wth,
                  child: TextField(
                    minLines: 4,
                    maxLines: 5,
                    controller: _inputController,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.green),
                      ),
                      hintText: 'STDIN',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "OUTPUT",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: wth > 600 ? wth * 0.4 : wth,
                  child: TextField(
                    readOnly: true,
                    minLines: 4,
                    maxLines: 5,
                    controller: _outputController,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: Colors.deepPurple),
                      ),
                      hintText: 'STDOUT',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: min(wth * 0.95, 600),
        height: 350,
        child: Center(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Column(children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.memory(base64Decode(images[index])),
                ),
                Text(image_names[index]),
              ]);
            },
          ),
        ),
      ),
    ]);
  }
}
