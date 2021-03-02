import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

const double windowHeight = 200;

class _MyAppState extends State<MyApp> {
  GlobalKey _qrKey = GlobalKey();
  var _qrText = "";
  QRViewController _controller;
  _launchURLBrowser(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int p = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: QRView(
                key: _qrKey,
                overlay: QrScannerOverlayShape(
                  borderRadius: 10,
                  borderColor: Colors.blueGrey,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
                onQRViewCreated: _onQRViewCreate),
          ),
          Container(
            color: Colors.transparent.withOpacity(0),
            alignment: Alignment.topCenter,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    '  QR Scanner',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    minWidth: 5,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: null,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: const Text(
                                                  'QR Scanner',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: const Text(
                                                  'by Mathrithms',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Colors.black,
                                          height: 1,
                                        ),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                            minWidth: 100, maxWidth: 300),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Version 0.0.1',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                '© Mathrithms 2021',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                'Licensed under GPL v3',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              const Text(
                                                ' ',
                                              ),
                                              Text(
                                                'Developers:',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                'Vaibhav Sharma',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Colors.black,
                                          height: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              minWidth: 100, maxWidth: 300),
                                          child: Row(
                                            children: [
                                              FlatButton(
                                                onPressed: () {
                                                  _launchURLBrowser(
                                                      'https://qrcodefeedback.mathrithms.com/');
                                                },
                                                child: Text(
                                                  'Send Feedback',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                'Github',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "i",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController _controller) {
    this._controller = _controller;
    _controller.scannedDataStream.listen((scanData) {
      setState(() async {
        _qrText = scanData;
        _controller.pauseCamera();
        showModalBottomSheet(
          enableDrag: true,
          context: context,
          builder: (BuildContext b) {
            return Container(
              color: Colors.white70,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    child: Text(
                      _qrText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => _launchURLBrowser(_qrText),
                  ),
                ),
              ),
            );
          },
        ).whenComplete(() async => _controller.resumeCamera());
      });
    });
  }
}
