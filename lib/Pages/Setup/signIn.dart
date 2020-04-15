import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services//auth.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 0, 40, 0),
          title: Text("Login Page"),
        ),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
                child: Text("Login with your credentials.",
                    style: Theme.of(context).textTheme.headline),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Email',
                          ),
                          validator: (input) {
                            if (!EmailValidator.validate(input)) {
                              return "Enter a valid email address.";
                            } else if (input.isEmpty) {
                              return "Please enter the email.";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return "Please enter the password.";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                        child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            onPressed: signIn,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            color: Colors.amberAccent,
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                        child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('error signing in');
                              } else {
                                print('signed in');
                                print(result);
                              }
                            },
                            child: Text(
                              "Sign In Anonymously",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            color: Colors.amberAccent,
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save(); // save email and password variables
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
