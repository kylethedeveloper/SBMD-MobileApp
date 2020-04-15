import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Pages/Setup/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 40, 0),
          title: Text("Sign Up Page"),
        ),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 50, 24, 18),
                child: Text("Register with your credentials.",
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
                            border: OutlineInputBorder(),
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
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (input) {
                            if (input.isEmpty) {
                              return "Please enter the password.";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          onSaved: (input) => _password = input,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          onPressed: signUp,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          color: Colors.amberAccent,
                          padding: const EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save(); // save email and password variables
      try {
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        //user.emailVerification();
        //TODO: Display user that an email is sent.
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
