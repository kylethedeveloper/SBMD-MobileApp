import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
	
	String message;
	
	Loading(String message) {
		this.message = message;
	}
	
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Colors.white,
			child: Center(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Expanded(
									child: Container(),
									flex: 2
							),
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: SpinKitPumpingHeart(
									color: Colors.red,
									size: 90.0,
								),
							),
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text(
									message,
									style: TextStyle(color: Color.fromARGB(255, 0, 40, 0), fontSize: 24, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
									textAlign: TextAlign.center,
								),
							),
							Expanded(
								child: Container(),
								flex: 2,
							),
							Padding(
								padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
								child: Text(
									"Made with love",
									style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.red),
									textAlign: TextAlign.center,
								),
							)
						],
					)
			),
		);
	}
}
