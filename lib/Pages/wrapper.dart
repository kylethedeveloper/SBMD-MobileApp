import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/homePage.dart';
import 'package:smart_baby_monitoring_device/Pages/Setup/welcome.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';

class Wrapper extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user data from the provider
		
		if (user == null) {
			print("--Returned Welcome Page--");
			return WelcomePage();
		}
		else {
			print("--Returned Home Page--");
			return HomePage();
		}
	}
}
