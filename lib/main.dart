import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Pages/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Wrapper(),
    );
  }
}