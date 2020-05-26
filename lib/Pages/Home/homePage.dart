import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/home.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/alerts.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/settings.dart';
import 'package:smart_baby_monitoring_device/Pages/Home/logs.dart';
import 'package:smart_baby_monitoring_device/Services/auth.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final AuthService _auth = AuthService();
	int _selectedIndex = 0;
	
	void _onItemTapped(int index) {
		setState(() {
		  _selectedIndex = index;
		});
	}
	
	static List<Widget> _widgetOptions = <Widget>[
		Home(),
		Alerts(),
		Logs(),
		Settings()
	];
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			//resizeToAvoidBottomInset: true,
			appBar: AppBar(
				backgroundColor: Color.fromARGB(255, 0, 40, 0),
				title: (() {
					if(_selectedIndex == 1) { return Text("Alerts"); }
					else if(_selectedIndex == 2) { return Text("Logs"); }
					else if(_selectedIndex == 3) { return Text("Settings"); }
					return Text("Home");
				}()),
				centerTitle: true,
				actions: <Widget>[
					FlatButton.icon(
						onPressed: () async {
							await _auth.signOut();
						},
						textColor: Colors.white,
						icon: Icon(Icons.block),
						label: Text("Sign Out"),
					)
				],
			),
			body: Center(
				child: _widgetOptions.elementAt(_selectedIndex),
			),
			bottomNavigationBar: Theme(
				data: Theme.of(context).copyWith(
						canvasColor: Color.fromARGB(255, 0, 40, 0)
				),
			  child: BottomNavigationBar(
			  	items: const <BottomNavigationBarItem>[
			  		BottomNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
			  		BottomNavigationBarItem(title: Text('Alerts'), icon: Icon(Icons.add_alert)),
			  		BottomNavigationBarItem(title: Text('Logs'), icon: Icon(Icons.note_add)),
			  		BottomNavigationBarItem(title: Text('Settings'), icon: Icon(Icons.settings))
			  	],
			  	currentIndex: _selectedIndex,
			  	selectedItemColor: Colors.white,
			  	unselectedItemColor: Colors.grey,
			  	selectedFontSize: 16.0,
			  	showUnselectedLabels: true,
			  	onTap: _onItemTapped,
			  ),
			),
		);
	}
}
