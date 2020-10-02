import 'package:barcode_scan/barcode_scan.dart';
import 'package:corona/component/MySubmitBtn.dart';
import 'package:corona/component/UpNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPage createState() => _ScanPage();
}

class _ScanPage extends State<ScanPage> {
  String codeResult = 'going scanning';
  bool isComplete = false;
  String id;
  String place;
  bool firstRun = true;

  void startScan() async {
    try {
      String codeScanner = await BarcodeScanner.scan();
      if (codeScanner != null) {
        print(codeScanner);
        setState(() {
          codeResult = codeScanner;
          isComplete = true;
          id = '1';
          place = 'مدينة اللحوم';
        });
      } else {
        setState(() {
          codeResult = 'something wrong!!!';
          isComplete = false;
        });
      }

      //Navigator.pop(context, qrCodeResult);
    } catch (e) {
      print(BarcodeScanner.CameraAccessDenied);

      //we can print that user has denied for the permisions
      //BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
    }
    setState(() {
      firstRun = false;
    });
  }

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            UpNavBar(
              title: 'نتيجة ماسح الكود',
              txtColor: Colors.white,
              bgColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 50,
            ),
            isComplete
                ? Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: 138,
                          height: 138,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 3),
                                    blurRadius: 6)
                              ]),
                          child: SvgPicture.asset(
                            'assets/icons/done.svg',
                            height: 75,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'أهلاً بك في',
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$place',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'تم تسجيل دخولك بنجاح',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        MySubmitBtn(
                          text: 'تسجيل دخول آخر',
                          toDo: () {
                            startScan();
                          },
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        firstRun
                            ? Container()
                            : Icon(
                                Icons.sms_failed_outlined,
                                color: Colors.red,
                                size: 80.0,
                              ),
                        Text(codeResult, style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'try again',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        MySubmitBtn(
                          text: 'حاول من جديد',
                          toDo: () {
                            startScan();
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

//its quite simple as that you can use try and catch staatements too for platform exception

  void showAlert({bool isComplete, String id, String place, String error}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: isComplete
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        width: 138,
                        height: 138,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 3),
                                  blurRadius: 6)
                            ]),
                        child: SvgPicture.asset(
                          'assets/icons/done.svg',
                          height: 75,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'أهلاً بك في',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      Text(
                        '$place',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'تم تسجيل دخولك بنجاح',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.sms_failed_outlined,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      Text(error, style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        error,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          );
        });
  }
}
