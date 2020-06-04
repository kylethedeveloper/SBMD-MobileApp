import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/alertsData.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

import 'alertsTile.dart';

class AlertsList extends StatefulWidget {
	@override
	_AlertsListState createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
	@override
	Widget build(BuildContext context) {
		final alerts = Provider.of<List<AlertsData>>(context); // access to alerts
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return StreamBuilder<List<AlertsData>>(
				stream: DatabaseService(uid: user.uid).alertsData,
				builder: (context, snapshot) {
					if (!snapshot.hasError) {
						switch (snapshot.connectionState) {
							case ConnectionState.none:
								return new Text(
									"Your phone is offline!",
									style: TextStyle(fontSize: 24, color: Colors.red),
									textAlign: TextAlign.center,
								);
							case ConnectionState.waiting:
								return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen)));
							default:
								if (alerts.length == 0) {
									return new Text(
										"Nothing to see.",
										style: TextStyle(fontSize: 24, color: Colors.red),
										textAlign: TextAlign.center,
									);
								}
								else {
									return ListView.builder(
										shrinkWrap: true,
										padding: EdgeInsets.only(top: 8, bottom: 4),
										itemCount: alerts.length,
										itemBuilder: (context, index) {
											return AlertsTile(alert: alerts[index]);
										},
									);
								}
						}
					}
					else {
						return new Text(
							"Error: ${snapshot.error}",
							style: TextStyle(fontSize: 17, color: Colors.red),
							textAlign: TextAlign.center,
						);
					}
				}
		);
	}
}
