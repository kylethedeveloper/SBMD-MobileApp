import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Pages/wrapper.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return StreamProvider<User>.value(
			value: AuthService().user,
			child: MaterialApp(
				home: Wrapper(),
			),
		);
	}
}
