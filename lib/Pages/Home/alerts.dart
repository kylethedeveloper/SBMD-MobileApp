import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/alertLimitsData.dart';
import 'package:smart_baby_monitoring_device/Models/alertsData.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/SidePages/forbiddenZone.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

import 'SidePages/alertsList.dart';

// TODO: create another dart file that checks the values and returns AlertLimitsData class to this page !!!
// TODO: TextInput Label = value, (if = -99 , empty)
// TODO: Switch is enabled if value != -99

class Alerts extends StatefulWidget {
	@override
	_AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		bool valueCheck(int val) {
			if (val != -99)
				return true;
			else
				return false;
		}
		
		return Container(
				margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
				child: StreamBuilder<AlertLimitsData>(
						stream: DatabaseService(uid: user.uid).alertsLimitsData,
						builder: (context, snapshot) {
							if (!snapshot.hasError) {
								AlertLimitsData a = snapshot.data; // get the data from snapshot
								switch (snapshot.connectionState) {
									case ConnectionState.none:
									// when connection is not established
										return new Text(
											"Your phone is offline!",
											style: TextStyle(fontSize: 24, color: Colors.red),
											textAlign: TextAlign.center,
										);
									case ConnectionState.waiting:
									// while waiting to retrieve data
										return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen)));
									default:
									/*bool checkConnection() {
											var _connectionDate = a.connection;
											var _newDate = _connectionDate.toDate().toUtc();
											if (_newDate
													.difference(DateTime.now())
													.inSeconds
													.toInt() > 10730) {
												return true;
											}
											else {
												DatabaseService(uid: user.uid).changeMonitoring(false);
												DatabaseService(uid: user.uid).changeMusic(0);
												return false;
											}
										} // checking the connection*/
										final tempBelow = TextEditingController(text: valueCheck(a.tempBelow) ? a.tempBelow.toString() : '');
										final tempAbove = TextEditingController(text: valueCheck(a.tempAbove) ? a.tempAbove.toString() : '');
										final humidBelow = TextEditingController(text: valueCheck(a.humidBelow) ? a.humidBelow.toString() : '');
										final humidAbove = TextEditingController(text: valueCheck(a.humidAbove) ? a.humidAbove.toString() : '');
										return SingleChildScrollView(
											child: Column(
													mainAxisAlignment: MainAxisAlignment.start,
													crossAxisAlignment: CrossAxisAlignment.center,
													children: <Widget>[
														Padding(
															padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text("When temperature below",
																		style: TextStyle(fontSize: 16),
																	),
																	Spacer(),
																	Container(
																		height: 30,
																		width: 70,
																		child: TextFormField(
																			decoration: InputDecoration(
																				errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
																				contentPadding: EdgeInsets.all(-10),
																				hintText: '0 to 22',
																				hintStyle: TextStyle(fontSize: 16),
																				alignLabelWithHint: true,
																				border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
																			),
																			style: TextStyle(fontSize: 16),
																			textAlign: TextAlign.center,
																			inputFormatters: [
																				WhitelistingTextInputFormatter(RegExp(r"^([0-9])$|^(1*[0-9])$|^(2[0-2]*)$")), // enter between 0-22
																				LengthLimitingTextInputFormatter(2),
																			],
																			keyboardType: TextInputType.number,
																			controller: tempBelow,
																		),
																	), // input field
																	Switch.adaptive(
																		activeColor: Colors.mySpecialGreen,
																		value: valueCheck(a.tempBelow),
																		onChanged: (val) async {
																			if (valueCheck(a.tempBelow)) {
																				await DatabaseService(uid: user.uid).setTempBelow();
																			}
																			else if ((tempBelow.text.length != 0) && !valueCheck(a.tempBelow)) {
																				int converted = int.parse(tempBelow.text);
																				await DatabaseService(uid: user.uid).setTempBelow(converted);
																			}
																		},
																	),
																],
															),
														), // when temp below
														Padding(
															padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text("When temperature above",
																		style: TextStyle(fontSize: 16),
																	),
																	Spacer(),
																	Container(
																		height: 30,
																		width: 70,
																		child: TextFormField(
																			decoration: InputDecoration(
																				errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
																				contentPadding: EdgeInsets.all(-10),
																				hintText: '24 to 45',
																				hintStyle: TextStyle(fontSize: 16),
																				alignLabelWithHint: true,
																				border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
																			),
																			style: TextStyle(fontSize: 16),
																			textAlign: TextAlign.center,
																			inputFormatters: [
																				WhitelistingTextInputFormatter(RegExp(r"^(2[4-9]*)$|^(3[0-9]*)$|^(4[0-5]*)$")), // enter between 24-45
																				LengthLimitingTextInputFormatter(2),
																			],
																			keyboardType: TextInputType.number,
																			controller: tempAbove,
																		),
																	), // input field
																	Switch.adaptive(
																		activeColor: Colors.mySpecialGreen,
																		value: valueCheck(a.tempAbove),
																		onChanged: (val) async {
																			if (valueCheck(a.tempAbove)) {
																				await DatabaseService(uid: user.uid).setTempAbove();
																			}
																			else if ((tempAbove.text.length != 0) && !valueCheck(a.tempAbove)) {
																				int converted = int.parse(tempAbove.text);
																				await DatabaseService(uid: user.uid).setTempAbove(converted);
																			}
																		},
																	),
																],
															),
														), // when temp above
														Padding(
															padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text("When humidity below",
																		style: TextStyle(fontSize: 16),
																	),
																	Spacer(),
																	Container(
																		height: 30,
																		width: 70,
																		child: TextFormField(
																			decoration: InputDecoration(
																				errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
																				contentPadding: EdgeInsets.all(-10),
																				hintText: '0 to 50',
																				hintStyle: TextStyle(fontSize: 16),
																				alignLabelWithHint: true,
																				border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
																			),
																			style: TextStyle(fontSize: 16),
																			textAlign: TextAlign.center,
																			inputFormatters: [
																				WhitelistingTextInputFormatter(RegExp(r"^([0-9])$|^([1-4]*[0-9])$|^(50)$")), // enter between 0-50
																				LengthLimitingTextInputFormatter(2),
																			],
																			keyboardType: TextInputType.number,
																			controller: humidBelow,
																		),
																	), // input field
																	Switch.adaptive(
																		activeColor: Colors.mySpecialGreen,
																		value: valueCheck(a.humidBelow),
																		onChanged: (val) async {
																			if (valueCheck(a.humidBelow)) {
																				await DatabaseService(uid: user.uid).setHumidBelow();
																			}
																			else if ((humidBelow.text.length != 0) && !valueCheck(a.humidBelow)) {
																				int converted = int.parse(humidBelow.text);
																				await DatabaseService(uid: user.uid).setHumidBelow(converted);
																			}
																		},
																	),
																],
															),
														), // when humid below
														Padding(
															padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text("When humidity above",
																		style: TextStyle(fontSize: 16),
																	),
																	Spacer(),
																	Container(
																		height: 30,
																		width: 70,
																		child: TextFormField(
																			decoration: InputDecoration(
																				errorStyle: TextStyle(letterSpacing: 1, fontSize: 12.5),
																				contentPadding: EdgeInsets.all(-10),
																				hintText: '55 to 80',
																				hintStyle: TextStyle(fontSize: 16),
																				alignLabelWithHint: true,
																				border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
																			),
																			style: TextStyle(fontSize: 16),
																			textAlign: TextAlign.center,
																			inputFormatters: [
																				WhitelistingTextInputFormatter(RegExp(r"^([5][5-9]*)$|^([67][0-9]*)$|^[8][0]*$")), // enter between 55-80
																				LengthLimitingTextInputFormatter(2),
																			],
																			keyboardType: TextInputType.number,
																			controller: humidAbove,
																		),
																	), // input field
																	Switch.adaptive(
																		activeColor: Colors.mySpecialGreen,
																		value: valueCheck(a.humidAbove),
																		onChanged: (val) async {
																			if (valueCheck(a.humidAbove)) {
																				await DatabaseService(uid: user.uid).setHumidAbove();
																			}
																			else if ((humidAbove.text.length != 0) && !valueCheck(a.humidAbove)) {
																				int converted = int.parse(humidAbove.text);
																				await DatabaseService(uid: user.uid).setHumidAbove(converted);
																			}
																		},
																	),
																],
															),
														), // when humid above
														Padding(
															padding: const EdgeInsets.fromLTRB(2, 1, 2, 2),
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text("Forbidden zone",
																		style: TextStyle(fontSize: 16),
																	),
																	Spacer(),
																	ButtonTheme(
																		height: 30,
																		minWidth: 70,
																		child: RaisedButton(
																			onPressed: () async {
																				// TODO: retrieve a snapshot from camera
																				Navigator.push(context, MaterialPageRoute(builder: (context) => ForbiddenZone()));
																			},
																			child: Text('Set', style: TextStyle(fontSize: 16, color: Colors.white)),
																			color: Colors.red[700],
																			padding: const EdgeInsets.all(8.0),
																			shape: RoundedRectangleBorder(
																					borderRadius: BorderRadius.circular(15.0)),
																		),
																	), // input field
																	Switch(value: false, onChanged: null,),
																],
															),
														), // set forbidden zone
														StreamProvider<List<AlertsData>>.value(
															value: DatabaseService(uid: user.uid).alertsData,
															child: AlertsList(),
														) // alerts list
													]),
										);
								}
							}
							else {
								return new Text(
									"Something wrong \nwith\n the server-side\n!!!",
									style: TextStyle(fontSize: 24, color: Colors.red),
									textAlign: TextAlign.center,
								);
							}
						}
				)
		
		);
	}
}
