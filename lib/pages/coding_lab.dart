import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/highlight.dart';
// Import the language & theme
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter/material.dart';
import 'package:assessmart/pages/hover.dart';
import 'dart:math';
import 'package:highlight/src/mode.dart';

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
                    items: <String>['CSE', 'Student', 'Teacher']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: OnHover(
                            //Wraping the DropDownMenuItem child so then when Items of drop down is hovering we see hovering effect
                            builder: (isHovered) {
                              final color =
                                  isHovered ? Colors.blue : Colors.black;
                              return Text(
                                value,
                                style: TextStyle(color: color),
                              );
                            },
                          ),
                        ),
                      );
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
                    items: <String>['DIP', 'CSE', 'Student', 'Teacher']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: OnHover(
                            //Wraping the DropDownMenuItem child so then when Items of drop down is hovering we see hovering effect
                            builder: (isHovered) {
                              final color =
                                  isHovered ? Colors.blue : Colors.black;
                              return Text(
                                value,
                                style: TextStyle(color: color),
                              );
                            },
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
                        items: <String>['CSE', 'Student', 'Teacher']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: OnHover(
                                builder: (isHovered) {
                                  final color =
                                      isHovered ? Colors.blue : Colors.black;
                                  return Text(
                                    value,
                                    style: TextStyle(color: color),
                                  );
                                },
                              ),
                            ),
                          );
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
                        items: <String>['DIP', 'CSE', 'Student', 'Teacher']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: OnHover(
                                //Wraping the DropDownMenuItem child so then when Items of drop down is hovering we see hovering effect
                                builder: (isHovered) {
                                  final color =
                                      isHovered ? Colors.blue : Colors.black;
                                  return Text(
                                    value,
                                    style: TextStyle(color: color),
                                  );
                                },
                              ),
                            ),
                          );
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
                const Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: TextField(
                        decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Teacher Id',
                    ))),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          block = Container(
                            height: 130,
                            color: Colors.amber,
                          );
                        });
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
                    maxLines: null,
                    controller:
                        TextEditingController(text: 'Description here..'),
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
              key: UniqueKey(),
            ),
          ]),
    );
  }
}

class CodeEditor extends StatefulWidget {
  const CodeEditor({required this.language, this.theme, this.source, Key? key})
      : super(key: key);
  final Mode? language;
  final Map<String, TextStyle>? theme;
  final String? source;
  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;

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
    super.dispose();
  }

  double fontsize = 14;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(
        height: 8,
      ),
      CodeField(
        controller: _codeController!,
        textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: fontsize),
        minLines: 10,
        maxLines: 20,
      ),
      FloatingActionButton(
        onPressed: () {
          setState(() {
            fontsize += 2;
          });
        },
        child: const Icon(
          Icons.text_increase,
          color: Colors.blue,
        ),
      )
    ]);
  }
}
