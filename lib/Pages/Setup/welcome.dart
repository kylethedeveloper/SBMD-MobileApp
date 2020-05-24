import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Pages/Setup/signIn.dart';
import 'package:smart_baby_monitoring_device/Pages/Setup/signUp.dart';

class WelcomePage extends StatefulWidget {
	@override
	_WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Color.fromARGB(255, 0, 40, 0),
				title: Text("Welcome!"),
				centerTitle: true,
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
							child: Text(
								"Welcome to Smart Baby Monitoring Device App. \nPlease register or login to use the product.",
								style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
								textAlign: TextAlign.center,
							),
						),
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: ButtonTheme(
								minWidth: 150.0,
								child: RaisedButton(
									onPressed: navigateToSignIn,
									child: Text('Login', style: TextStyle(fontSize: 18)),
									color: Colors.amberAccent,
									padding: const EdgeInsets.all(14.0),
									shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(15.0)),
								),
							),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
							child: ButtonTheme(
								shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(15.0)),
								minWidth: 150.0,
								child: RaisedButton(
									onPressed: navigateToSignUp,
									child: Text('Register', style: TextStyle(fontSize: 18)),
									color: Colors.amberAccent,
									padding: const EdgeInsets.all(14.0),
								),
							),
						),
					],
				),
			),
		);
	}
	
	void navigateToSignIn() {
		Navigator.push(
				context,
				MaterialPageRoute(
						builder: (context) => LoginPage(), fullscreenDialog: true));
	}
	
	void navigateToSignUp() {
		Navigator.push(
				context,
				MaterialPageRoute(
						builder: (context) => SignUpPage(), fullscreenDialog: true));
	}
}
