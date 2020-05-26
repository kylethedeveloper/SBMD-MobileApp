import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';


class Settings extends StatefulWidget {
	@override
	_SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
	final AuthService _auth = AuthService();
	
	@override
	Widget build(BuildContext context) {
		return Container(
			margin: EdgeInsets.fromLTRB(16, 48, 16, 48),
			child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 4, bottom: 4),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Change Password ",
										style: TextStyle(fontSize: 24),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () {},
											child: Text('Change', style: TextStyle(fontSize: 18)),
											color: Colors.amberAccent,
											padding: const EdgeInsets.all(8.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(15.0)),
										),
									),
								],
							),
						), // change password
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 4, bottom: 4),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Reset Setup ",
										style: TextStyle(fontSize: 24),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () {},
											child: Text('Reset', style: TextStyle(fontSize: 18)),
											color: Colors.red[800],
											textColor: Colors.white,
											padding: const EdgeInsets.all(8.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(15.0)),
										),
									),
								],
							),
						), // reset setup
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 4, bottom: 4),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Delete Account ",
										style: TextStyle(fontSize: 24),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () {},
											child: Text('Delete', style: TextStyle(fontSize: 18)),
											color: Colors.red[900],
											textColor: Colors.white,
											padding: const EdgeInsets.all(8.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(15.0)),
										),
									),
								],
							),
						), // delete account
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
					]),
		);
	}
}
