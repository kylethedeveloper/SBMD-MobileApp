import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';


class Logs extends StatefulWidget {
	@override
	_LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
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
											text: "LOGS PAGE: ",
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
