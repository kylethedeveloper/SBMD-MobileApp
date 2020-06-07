import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Models/alertsData.dart';

class AlertsTile extends StatelessWidget {
	
	final AlertsData alert;
	
	AlertsTile({this.alert});
	
	@override
	Widget build(BuildContext context) {
		var _alert = alert.alert;
		var _date = alert.date;
		//bool warning = false;
		return Padding(
			//padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
			padding: const EdgeInsets.all(2.0),
			child: Card(
				margin: EdgeInsets.only(left: 5, right: 5),
				color: Colors.red[200],
				child: ListTile(
					//contentPadding: ,
					title: Text(_alert, style: TextStyle(fontWeight: FontWeight.bold),),
					subtitle: Text(_date.toDate().toUtc().toString().substring(0, 16), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
					trailing: Icon(Icons.warning),
				),
			),
		);
	}
}
