import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/logsData.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

import 'logsList.dart';

// TODO: change log interval

class Logs extends StatefulWidget {
	@override
	_LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return StreamProvider<List<LogsData>>.value(
			value: DatabaseService(uid: user.uid).logsData,
			child: LogsList(),
		);
	}
}
