import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

class Settings extends StatefulWidget {
	@override
	_SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return Container(
			margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
			child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 2, bottom: 2),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Change Password ",
										style: TextStyle(fontSize: 22),
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
							padding: const EdgeInsets.only(top: 2, bottom: 2),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Clear Logs ",
										style: TextStyle(fontSize: 22),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () async {
												await DatabaseService(uid: user.uid).clearLogs();
											},
											child: Text('Clear', style: TextStyle(fontSize: 18)),
											color: Colors.amberAccent,
											padding: const EdgeInsets.all(8.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(15.0)),
										),
									),
								],
							),
						), // clear logs // TODO: Prompt before clearing
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 2, bottom: 2),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Clear Alerts ",
										style: TextStyle(fontSize: 22),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () async {
												await DatabaseService(uid: user.uid).clearAlerts();
											},
											child: Text('Clear', style: TextStyle(fontSize: 18)),
											color: Colors.amber,
											padding: const EdgeInsets.all(8.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(15.0)),
										),
									),
								],
							),
						), // clear alerts // TODO: Prompt before clearing
						Divider(
							color: Colors.blueGrey,
							thickness: 1,
						),
						Padding(
							padding: const EdgeInsets.only(top: 2, bottom: 2),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Reset Setup ",
										style: TextStyle(fontSize: 22),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () async {
												await DatabaseService(uid: user.uid).resetSetup(false);
											},
											child: Text('Reset', style: TextStyle(fontSize: 18)),
											color: Colors.amber[700],
											textColor: Colors.black,
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
							padding: const EdgeInsets.only(top: 2, bottom: 2),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("Delete Account ",
										style: TextStyle(fontSize: 22),
									),
									ButtonTheme(
										minWidth: 100,
										child: RaisedButton(
											onPressed: () {},
											child: Text('Delete', style: TextStyle(fontSize: 18)),
											color: Colors.amber[900],
											textColor: Colors.black,
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
