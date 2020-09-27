import 'package:corona/component/UpNavBar.dart';
import 'package:corona/splash.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String test;
  HomeScreen({this.test});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String data;

  void getData() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      data = 'data loaded successfully';
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: data == null
            ? SplashScreen()
            : Stack(
                children: [
                  Center(child: Text(widget.test)),
                  UpNavBar(
                    title: widget.test,
                    iconData: 'assets/icons/notifications.svg',
                    onIconPressed: () {
                      print('notifications pressed');
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
