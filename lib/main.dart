import 'package:corona/pages/firstLaunch/boardingAndRegister.dart';
import 'package:corona/pages/mainSceenTaber.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        fontFamily: 'Cairo',
        primaryColor: Color(0xFF2FA05E),
        accentColor: Color(0xFF00DB75),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'خليك بأمان'),
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
  int theFirstRun;

  void checkLaunchTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('firstLaunch')) {
      theFirstRun = 0;
    } else {
      theFirstRun = int.parse(prefs.getString('firstLaunch'));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLaunchTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: theFirstRun == 0
              ? BoardingScreen(
                  context: context,
                )
              : MainScreenTaber()),
    );
  }
}
