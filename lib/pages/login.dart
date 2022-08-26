import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: const Text("Login to Your Account"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    var wth = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: min(400, wth),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Email',
                  labelText: 'Email *',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Your Email");
                  }
                  // reg expression for email validation
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  return null;
                },
                onSaved: (value) {
                  emailController.text = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: passwordController,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Password is required for login");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Password(Min. 6 Character)");
                  }
                },
                onSaved: (value) {
                  passwordController.text = value!;
                },
                textInputAction: TextInputAction.done,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                      height: 35,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          signIn(emailController.text, passwordController.text);
                        },
                        child: const Text('Login'),
                      )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                  child: Center(
                    child: SizedBox(
                      height: 35,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {},
                        child: const Text('Forgot Password'),
                      ),
                    ),
                  )),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Don\'t have an account yet? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'SignUp',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/register');
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

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false)
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Make sure You have network connection";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
