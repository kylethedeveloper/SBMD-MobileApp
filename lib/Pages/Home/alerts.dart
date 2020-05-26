import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';


class Alerts extends StatefulWidget {
	@override
	_AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
	final AuthService _auth = AuthService();
	
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: Text.rich(
									TextSpan(
											text: "ALERTS PAGE: ",
											style: TextStyle(fontSize: 24),
											children: <TextSpan>[
												TextSpan(text: "INSERT")
											]
									)),
						),
					]),
		);
	}
}
