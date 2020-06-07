import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Models/logsData.dart';

class LogsTile extends StatelessWidget {
	
	final LogsData log;
	
	LogsTile({this.log});
	
	@override
	Widget build(BuildContext context) {
		var _temp = log.temp;
		var _humid = log.humid;
		var _date = log.date;
		//bool warning = false;
		return Padding(
			padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
			child: Card(
				margin: EdgeInsets.only(left: 10, right: 10),
				color: Colors.white70,
				child: ListTile(
					title: Text("Temperature: $_temp°C -- Humidity: %$_humid"),
					subtitle: Text(_date.toDate().toUtc().toString().substring(0, 16), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
					trailing: Icon(Icons.info_outline),
				),
			),
		);
	}
}
