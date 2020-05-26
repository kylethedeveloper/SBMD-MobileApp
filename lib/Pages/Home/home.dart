import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Models/userData.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';


class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	//final AuthService _auth = AuthService();
	//TODO: Connection status boolean error
	//TODO: music active color disappears after changing page
	//TODO: not responsive
	
	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context); // accessing the user ID from the provider
		return Container(
			child: Padding(
				padding: const EdgeInsets.only(bottom: 8, top: 16),
				child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Padding(
								padding: const EdgeInsets.only(left: 14, bottom: 8),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.start,
									children: <Widget>[
										Text("Monitoring Mode ",
											style: TextStyle(fontSize: 20),
										),
										Spacer(flex: 2,),
										Switch(value: false, onChanged: null),
										Spacer()
									],
								),
							), // monitoring mode
							Padding(
								padding: const EdgeInsets.only(left: 14, bottom: 8),
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
												onPressed: () {},
												child: Text('Watch', style: TextStyle(fontSize: 18)),
												color: Colors.amberAccent,
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
								padding: const EdgeInsets.only(left: 14, top: 8, bottom: 8, right: 14),
								child: StreamBuilder<UserData>(
										stream: DatabaseService(uid: user.uid).userData,
										builder: (context, snapshot) {
											if (!snapshot.hasError) {
												UserData userData = snapshot.data; // get the data from snapshot
												switch (snapshot.connectionState) {
													case ConnectionState.none:
													// when connection is not established
														return new Text(
															"Offline!",
															style: TextStyle(fontSize: 24, color: Colors.red),
															textAlign: TextAlign.center,
														);
													case ConnectionState.waiting:
													// while waiting to retrieve data
														return Center(child: CircularProgressIndicator());
													default:
													// TODO: if device status false, show something else
														int music = userData.music;
														return Column(
															//mainAxisAlignment: MainAxisAlignment.start,
															crossAxisAlignment: CrossAxisAlignment.start,
															children: <Widget>[
																Padding(
																	padding: const EdgeInsets.only(bottom: 18),
																	child: Text.rich(
																			TextSpan(
																					text: "Device Status: ",
																					style: TextStyle(fontSize: 20),
																					children: <TextSpan>[
																						TextSpan(
																								text: userData.setup ? "Connected" : "Disconnected",
																								style: userData.setup ? TextStyle(color:
																								Colors.green) : TextStyle(color:
																								Colors.red)
																						)
																					]
																			)),
																), // device status
																Center(
																	child: Padding(
																		padding: EdgeInsets.only(bottom: 6),
																		child: Text(
																			"Sensor Readings",
																			textAlign: TextAlign.center,
																			style: TextStyle(
																					fontSize: 24,
																					color: Colors.red,
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
																				TextSpan(
																						text: userData.temp,
																						style: TextStyle(fontSize: 24),
																						children: <TextSpan>[
																							TextSpan(text: " °C")
																						]
																				)),
																		Text.rich(
																				TextSpan(
																						text: "%",
																						style: TextStyle(fontSize: 24),
																						children: <TextSpan>[
																							TextSpan(text: userData.humid, style: TextStyle())
																						]
																				)),
																	],
																), // sensor readings values
																Padding(
																	padding: const EdgeInsets.only(top: 8),
																	child: ListView(
																		shrinkWrap: true,
																		children: <Widget>[
																			Card(
																				color: (() { if(music == 1) { return Colors.lightGreen[300]; } return null;}()),
																				child: ListTile(
																					leading: Icon(Icons.music_note),
																					title: Text("Music #1", style: TextStyle(fontSize: 18),),
																					onTap: () async {
																						await DatabaseService(uid: user.uid).changeMusic(1);
																						setState(() {
																							music = 1;
																						  /*music1 = true;
																						  music2 = false;
																						  music3 = false;*/
																						});
																					},
																				),
																			), // music 1
																			Card(
																				color: (() { if(music == 2) { return Colors.lightGreen[300]; } return null;}()),
																				//music2 ? Colors.lightGreen[300] : null,
																				child: ListTile(
																					leading: Icon(Icons.music_note),
																					title: Text("Music #2", style: TextStyle(fontSize: 18),),
																					onTap: () async {
																						await DatabaseService(uid: user.uid).changeMusic(2);
																						setState(() {
																							music = 2;
																						});
																					},
																				),
																			), // music 2
																			Card(
																				color: (() { if(music == 3) { return Colors.lightGreen[300]; } return null;}()),
																				child: ListTile(
																					leading: Icon(Icons.music_note),
																					title: Text("Music #3", style: TextStyle(fontSize: 18),),
																					onTap: () async {
																						await DatabaseService(uid: user.uid).changeMusic(3);
																						setState(() {
																							music = 3;
																						});
																					},
																				),
																			), // music 3
																		],
																	),
																), // music cards // TODO: if not connected disabled
																Center(
																	child: RaisedButton.icon(
																		onPressed: () async {
																			await DatabaseService(uid: user.uid).changeMusic(0);
																			setState(() {
																				music = 0;
																			});
																		},
																		icon: Icon(Icons.stop),
																		textColor: Colors.white,
																		label: Text("Stop Music", style: TextStyle(fontSize: 18),),
																		color: Colors.red,
																		shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(16.0)),
																	),
																) // stop music button // TODO: if not connected disabled
															],
														
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
							), // device status and below
						]),
			),
		);
	}
}
