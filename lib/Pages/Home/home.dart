import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final AuthService _auth = AuthService();
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Color.fromARGB(255, 0, 40, 0),
				title: Text("Home Page"),
				centerTitle: true,
				actions: <Widget>[
					FlatButton.icon(
						onPressed: () async {
							await _auth.signOut();
						},
						textColor: Colors.white,
						icon: Icon(Icons.block),
						label: Text("Sign Out"),
					)
				],
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(14.0),
							child: Text(
								"Welcome to Smart Baby Monitoring Device App. \n\nThis is the Home Page.",
								style: TextStyle(fontSize: 17),
								textAlign: TextAlign.center,
							),
						),
					],
				),
			),
		);
	}
}
