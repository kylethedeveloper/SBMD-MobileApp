import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';
import 'package:smart_baby_monitoring_device/Shared/loading.dart';

class SignUpPage extends StatefulWidget {
	@override
	_SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
	final AuthService _auth = AuthService();
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	String _email, _password;
	bool loading = false;
	
	@override
	Widget build(BuildContext context) {
		return loading ? Loading(message: 'Registering...') : Scaffold(
				appBar: AppBar(
					backgroundColor: Colors.mySpecialGreen,
					title: Text("Sign Up Page"),
				),
				//resizeToAvoidBottomPadding: false,
				body: Center(
					child: SingleChildScrollView(
					  child: Column(
					  	crossAxisAlignment: CrossAxisAlignment.center,
					  	children: <Widget>[
					  		Padding(
					  			padding: const EdgeInsets.fromLTRB(24, 50, 24, 18),
					  			child: Text("Register with your credentials.", style: Theme
					  					.of(context)
					  					.textTheme
					  					.headline),
					  		),
					  		Form(
					  				key: _formKey,
					  				child: Column(
					  					children: <Widget>[
					  						Padding(
					  							padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
					  							child: TextFormField(
					  								decoration: InputDecoration(
					  									errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
					  									icon: Icon(Icons.email),
					  									alignLabelWithHint: true,
					  									border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
					  									labelText: 'Email',
					  								),
					  								validator: (input) {
					  									if (!EmailValidator.validate(input)) {
					  										return "Enter a valid email address.";
					  									}
					  									else if (input.isEmpty) {
					  										return "Please enter the email.";
					  									}
					  									else {
					  										return null;
					  									}
					  								},
					  								onSaved: (input) => _email = input,
					  							),
					  						),
					  						Padding(
					  							padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
					  							child: TextFormField(
					  								decoration: InputDecoration(
					  									errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
					  									icon: Icon(Icons.lock),
					  									alignLabelWithHint: true,
					  									border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
					  									labelText: 'Password',
					  								),
					  								validator: (input) {
					  									if (input.isEmpty) {
					  										return "Please enter the password.";
					  									}
					  									else if (input.length <= 6) {
					  										return "Password must be at least 6 characters.";
					  									}
					  									else {
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
					  								onPressed: () async {
					  									final formState = _formKey.currentState;
					  									if (formState.validate()) { // if the inputs are valid
					  										formState.save(); // save email and password variables
					  										setState(() => loading = true); // loading screen on
					  										dynamic result = await _auth.signUp(_email, _password);
					  										if (result == null) {
					  											print("Couldn't sign up. Try again later.");
					  											setState(() => loading = false); // loading screen off
					  										}
					  										else {
					  											print('signed up');
					  											print(result.uid); // print the uid to the console
					  											//print(result.isEmailVerified); // print if email is verified to the console
					  											if (Navigator.canPop(context)) {
					  												print("PopHereSignUp"); // info print
					  												Navigator.pop(context); // pop the login screen to previous one
					  											}
					  										}
					  									}
					  									else {
					  										print("Not Valid Inputs");
					  									}
					  								},
					  								child: Text(
					  									"Register",
					  									textAlign: TextAlign.center,
					  									style: TextStyle(fontSize: 16),
					  								),
					  								color: Colors.amberAccent,
					  								padding: const EdgeInsets.all(12.0),
					  								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
					  							),
					  						)
					  					],
					  				))
					  	],
					  ),
					),
				));
	}
}
