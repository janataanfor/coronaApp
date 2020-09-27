import 'package:barcode_scan/barcode_scan.dart';
import 'package:corona/component/UpNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:corona/component/MySubmitBtn.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";

  startScan() async {
    try {
      String codeScanner = await BarcodeScanner.scan();
      if (codeScanner != null) {
        print(codeScanner);
      }
      setState(() {
        qrCodeResult = codeScanner;
      });
      //Navigator.pop(context, qrCodeResult);
    } catch (e) {
      print(BarcodeScanner.CameraAccessDenied);

      //we can print that user has denied for the permisions
      //BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
    }
  }

  @override
  void initState() {
    super.initState();
    //startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            UpNavBar(
              title: 'Scanner',
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Scaned QR code",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Align QR code within frame to scan',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontStyle: FontStyle.normal),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                'content: \"$qrCodeResult\"',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            MySubmitBtn(
              text: 'Scan',
              toDo: startScan,
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

//its quite simple as that you can use try and catch staatements too for platform exception

  void showAlert({bool isComplete, String balance, String error}) {
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
                          'asset/icons/done.svg',
                          height: 75,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'transfer confirmed',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      Text(
                        'your Balance:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$balance IQD',
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
                      Text('transfer failed', style: TextStyle(fontSize: 18)),
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
