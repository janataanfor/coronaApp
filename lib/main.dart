import 'package:corona/boardingAndRegister.dart';
import 'package:corona/mainSceenTaber.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF2FA05E),
        accentColor: Color(0xFF00DB75),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool theFirstRun = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: theFirstRun ? BoardingScreen() : MainScreenTaber(),
    );
  }
}
