import 'package:corona/component/UpNavBar.dart';
import 'package:corona/pages/firstLaunch/splash.dart';
import 'package:corona/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String test;

  HomeScreen({this.test});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> data;
  int status = 0;
  int type;
  void getData() async {
    await Future.delayed(Duration(milliseconds: 1500));
    data = List<Map<String, String>>();
    setState(() {
      data.add({
        'status': 'data loaded successfully',
        'fName': 'محمد',
        'avatar_url': ''
      });
    });
    print(data[0]);
  }

  void getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = int.parse(prefs.getString('userType'));
  }

  @override
  void initState() {
    getData();
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: data == null
            ? SplashScreen()
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 46,
                              width: 46,
                              child: ClipOval(
                                child: data[0]['avatar_url'] == ''
                                    ? Image(
                                        image: AssetImage(
                                            'assets/images/sun boy.jpg'),
                                      )
                                    : Image.network(
                                        data[0]['avatar_url'],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'أهلاُ بك ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${data[0]['fName']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 105,
                              width: 105,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 3),
                                        blurRadius: 6)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset('assets/images/rVirus.svg'),
                                  Text(
                                    'إجمالي الحالات',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 105,
                              width: 105,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 3),
                                        blurRadius: 6)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/gVirus.svg',
                                  ),
                                  Text(
                                    'حالات اليوم',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 105,
                              width: 105,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 3),
                                        blurRadius: 6)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset('assets/images/virus.svg'),
                                  Text(
                                    'إجمالي الوفيات',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text('20')
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              type == 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      height: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 3),
                                                blurRadius: 6)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'حالتي الصحية',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.right,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 53,
                                                    decoration: BoxDecoration(
                                                      color: status == 0
                                                          ? Colors.green
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  Text(
                                                    'سليم',
                                                    style: TextStyle(
                                                        color: status == 0
                                                            ? Colors.green
                                                            : Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  status == 0
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          height: 5,
                                                          width: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: status == 0
                                                                ? Colors.green
                                                                : Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 53,
                                                    decoration: BoxDecoration(
                                                      color: status == 1
                                                          ? Colors.orangeAccent
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  Text(
                                                    'مخالط',
                                                    style: TextStyle(
                                                        color: status == 1
                                                            ? Colors
                                                                .orangeAccent
                                                            : Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  status == 1
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          height: 5,
                                                          width: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: status == 1
                                                                ? Colors
                                                                    .orangeAccent
                                                                : Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 53,
                                                    decoration: BoxDecoration(
                                                      color: status == 2
                                                          ? Colors.redAccent
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  Text(
                                                    'مصاب',
                                                    style: TextStyle(
                                                        color: status == 2
                                                            ? Colors.redAccent
                                                            : Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  status == 2
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          height: 5,
                                                          width: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: status == 2
                                                                ? Colors
                                                                    .redAccent
                                                                : Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      height: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 3),
                                                blurRadius: 6)
                                          ]),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              'assets/images/logo.png',
                                            ),
                                            width: 120,
                                          ),
                                          Text(
                                            'مدينة اللحوم',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Icon(
                                                Icons.trending_up,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              Text('21/40',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: SvgPicture.asset(
                                      'assets/images/qr-code.svg',
                                      width: 220,
                                    ),
                                    decoration: BoxDecoration(
                                        color: type == 0
                                            ? Colors.white
                                            : Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  UpNavBar(
                    iconData: 'assets/icons/notifications.svg',
                    bgColor: Theme.of(context).primaryColor,
                    txtColor: Colors.white,
                    onIconPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
