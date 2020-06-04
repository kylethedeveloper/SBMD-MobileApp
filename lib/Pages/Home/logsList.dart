import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/logsData.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

import 'logsTile.dart';

class LogsList extends StatefulWidget {
	@override
	_LogsListState createState() => _LogsListState();
}

class _LogsListState extends State<LogsList> {
	@override
	Widget build(BuildContext context) {
		final logs = Provider.of<List<LogsData>>(context); // access to logs
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return StreamBuilder<List<LogsData>>(
				stream: DatabaseService(uid: user.uid).logsData,
				builder: (context, snapshot) {
					if (!snapshot.hasError) {
						switch (snapshot.connectionState) {
							case ConnectionState.none:
								return new Text(
									"Offline!",
									style: TextStyle(fontSize: 24, color: Colors.red),
									textAlign: TextAlign.center,
								);
							case ConnectionState.waiting:
								return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen)));
							default:
								if (logs.length == 0) {
									return new Text(
										"Nothing to see.",
										style: TextStyle(fontSize: 24, color: Colors.red),
										textAlign: TextAlign.center,
									);
								}
								else {
									return ListView.builder(
										padding: EdgeInsets.only(top: 8, bottom: 8),
										itemCount: logs.length,
										itemBuilder: (context, index) {
											return LogsTile(log: logs[index]);
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
