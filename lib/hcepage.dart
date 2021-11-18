import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:nfc_emulator/nfc_emulator.dart';
import 'package:ola_mundo/homepage.dart';

class HCEpage extends StatefulWidget {
  const HCEpage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;
  @override
  _HCEpageState createState() => _HCEpageState();
}

class _HCEpageState extends State<HCEpage> {
  String _platformVersion = 'Unknown';
  NfcStatus _nfcStatus = NfcStatus.unknown;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    NfcStatus nfcStatus = NfcStatus.unknown;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = (await NfcEmulator.platformVersion)!;
      nfcStatus = await NfcEmulator.nfcStatus;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _nfcStatus = nfcStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('FareSeer - Paying Page'),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => HomePage(camera: widget.camera)),
              );
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Status: $_nfcStatus'),
                SizedBox(height: 40.0),
                RaisedButton(
                    child: Text(_started ? "Stop NFC" : "Pay"),
                    onPressed: startStopEmulator),
              ]),
        ),
      ),
    );
  }

  void startStopEmulator() async {
    if (_started) {
      await NfcEmulator.stopNfcEmulator();
    } else {
      await NfcEmulator.startNfcEmulator(
          "666B65630001", globals.id, "79e64d05ed6475d3acf405d6a9cd506b");
    }
    setState(() {
      _started = !_started;
    });
  }
}
