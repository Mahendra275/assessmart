import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:assessmart/pages/hover.dart';
import 'dart:math';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("SIGN UP for SmartAccess"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegistrationFormState extends State<RegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? role, section = 'Section 1', dept = 'CSE';
  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width;
    // Build a Form widget using the _formKey created above.
    return Center(
      child: SizedBox(
        width: min(400, wth),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Username/ID',
                  labelText: 'Username/ID *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username/ID is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter your Password',
                  labelText: 'Password *',
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Name',
                  labelText: 'Name *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Text('Choose Role')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      value: role,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      hint: const Text('Select type'),
                      underline: Container(
                        height: 2,
                        color: Colors.black26,
                      ),
                      items: <String>['Student', 'Teacher']
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
                          role = newValue!;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Text('Section (for Students)')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      value: section,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.black26,
                      ),
                      items: <String>[
                        'Section 1',
                        'Section 2',
                        'Section 3',
                        'Section 4',
                        'Section 5',
                        'Section 6'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                          section = newValue!;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your Email',
                  labelText: 'Email *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Text('Select Department')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      value: dept,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black26,
                      ),
                      items: <String>[
                        'CSE',
                        'ECE',
                        'MECH',
                        'CHE',
                        'CIVIL',
                        'MME',
                        'Mathemathics',
                        'Physics',
                        'Chemistry',
                        'Management'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      isExpanded: true,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                    height: 35,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Already have account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/login');
                          }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
