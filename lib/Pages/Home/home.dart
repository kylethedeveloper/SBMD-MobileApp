import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Models/userData.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

import 'SidePages/liveStream.dart';


class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	
	//TODO: music active color disappears after changing page
	//TODO: not responsive
	//TODO: if device status false, show something else
	
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return Container(
			child: Padding(
				padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
				child: StreamBuilder<UserData>(
						stream: DatabaseService(uid: user.uid).userData,
						builder: (context, snapshot) {
							if (!snapshot.hasError) {
								UserData userData = snapshot.data; // get the data from snapshot
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
										bool checkConnection() {
											var _connectionDate = userData.connection;
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
												DatabaseService(uid: user.uid).changeLiveStream(false);
												return false;
											}
											/*print(_newDate);
											print(_newDate.second);
											print(DateTime.now());
											print(DateTime.now().second);
											print(_newDate.difference(DateTime.now()).inSeconds);
											print("-------");*/
										} // checking the connection
										int music = userData.music;
										return SingleChildScrollView(
											child: Column(
												mainAxisAlignment: MainAxisAlignment.center,
												crossAxisAlignment: CrossAxisAlignment.start,
												children: <Widget>[
													Padding(
														padding: const EdgeInsets.only(bottom: 4),
														child: Row(
															mainAxisAlignment: MainAxisAlignment.start,
															children: <Widget>[
																Text("Alert Mode ",
																	style: TextStyle(fontSize: 20),
																),
																Spacer(flex: 3,),
																Switch.adaptive(
																	value: userData.monitoringMode ? true : false,
																	onChanged: (val) async {
																		await DatabaseService(uid: user.uid).changeMonitoring(val);
																	},
																	activeColor: Colors.mySpecialGreen,),
																Spacer()
															],
														),
													), // alert mode
													Padding(
														padding: const EdgeInsets.only(bottom: 12),
														child: Row(
															mainAxisAlignment: MainAxisAlignment.start,
															children: <Widget>[
																Text("Watch the camera ",
																	style: TextStyle(fontSize: 20),
																),
																Spacer(flex: 2,),
																ButtonTheme(
																	minWidth: 100,
																	child: RaisedButton(
																		onPressed: checkConnection() ? () async {
																			await DatabaseService(uid: user.uid).changeLiveStream(true);
																			Navigator.push(
																					context,
																					MaterialPageRoute(
																							builder: (context) => LiveStream(uid: user.uid), fullscreenDialog: true));
																		}
																				: null,
																		child: Text('Watch', style: TextStyle(fontSize: 18, color: Colors.white)),
																		color: Colors.mySpecialGreen,
																		padding: const EdgeInsets.all(8.0),
																		shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(15.0)),
																	),
																),
																Spacer()
															],
														),
													), // watch the camera
													Padding(
														padding: const EdgeInsets.only(bottom: 8),
														child: Text.rich(
																TextSpan(
																		text: "Device Status: ",
																		style: TextStyle(fontSize: 20),
																		children: <TextSpan>[
																			TextSpan(
																					text: checkConnection() ? "Connected" : "Disconnected",
																					style: checkConnection() ? TextStyle(color:
																					Colors.green) : TextStyle(color:
																					Colors.red)
																			)
																		]
																)),
													), // device status
													Center(
														child: Padding(
															padding: EdgeInsets.only(top: 6, bottom: 6),
															child: Text(
																"Sensor Readings",
																textAlign: TextAlign.center,
																style: TextStyle(
																		fontSize: 22,
																		decoration: TextDecoration.underline,
																		fontWeight: FontWeight.bold),
															),
														),
													), // sensor readings heading
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceEvenly,
														children: <Widget>[
															Icon(Icons.hot_tub),
															Icon(Icons.cloud)
														],
													), // sensor readings icons
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceEvenly,
														children: <Widget>[
															Text.rich(
																	checkConnection() ?
																	TextSpan(
																			text: userData.temp,
																			style: TextStyle(fontSize: 22),
																			children: <TextSpan>[
																				TextSpan(text: " °C")
																			]
																	) :
																	TextSpan(text: "Unavailable!", style: TextStyle(color: Colors.red, fontSize: 22))
															),
															Text.rich(
																	checkConnection() ?
																	TextSpan(
																			text: "%",
																			style: TextStyle(fontSize: 22),
																			children: <TextSpan>[
																				TextSpan(text: userData.humid, style: TextStyle())
																			]
																	) :
																	TextSpan(text: "Unavailable!", style: TextStyle(color: Colors.red, fontSize: 22))
															),
														],
													), // sensor readings values
													Padding(
														padding: const EdgeInsets.only(top: 8),
														child: ListView(
															shrinkWrap: true,
															children: <Widget>[
																Card(
																	color: (() {
																		if (music == 1) {
																			return Colors.lightGreen[300];
																		}
																		return null;
																	}()),
																	child: ListTile(
																		leading: Icon(Icons.music_note),
																		title: Text("Music #1", style: TextStyle(fontSize: 18),),
																		onTap: checkConnection() ? () async {
																			await DatabaseService(uid: user.uid).changeMusic(1);
																			setState(() {
																				music = 1;
																				/*music1 = true;
										  								  music2 = false;
										  								  music3 = false;*/
																			});
																		} : null,
																	),
																), // music 1
																Card(
																	color: (() {
																		if (music == 2) {
																			return Colors.lightGreen[300];
																		}
																		return null;
																	}()),
																	//music2 ? Colors.lightGreen[300] : null,
																	child: ListTile(
																		leading: Icon(Icons.music_note),
																		title: Text("Music #2", style: TextStyle(fontSize: 18),),
																		onTap: checkConnection() ? () async {
																			await DatabaseService(uid: user.uid).changeMusic(2);
																			setState(() {
																				music = 2;
																			});
																		} : null,
																	),
																), // music 2
																Card(
																	color: (() {
																		if (music == 3) {
																			return Colors.lightGreen[300];
																		}
																		return null;
																	}()),
																	child: ListTile(
																		leading: Icon(Icons.music_note),
																		title: Text("Music #3", style: TextStyle(fontSize: 18),),
																		onTap: checkConnection() ? () async {
																			await DatabaseService(uid: user.uid).changeMusic(3);
																			setState(() {
																				music = 3;
																			});
																		} : null,
																	),
																), // music 3
															],
														),
													), // music cards
													Center(
														child: RaisedButton.icon(
															
															onPressed: checkConnection() ? () async {
																await DatabaseService(uid: user.uid).changeMusic(0);
																setState(() {
																	music = 0;
																});
															} : null,
															icon: Icon(Icons.stop),
															textColor: Colors.white,
															label: Text("Stop Music", style: TextStyle(fontSize: 18),),
															color: Colors.red[700],
															shape: RoundedRectangleBorder(
																	borderRadius: BorderRadius.circular(16.0)),
														),
													) // stop music button
												],
											
											),
										);
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
				),
			),
		);
	}
}
