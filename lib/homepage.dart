import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ola_mundo/camera.dart' as foto;
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'appcontroller.dart';
import 'credits.dart';
import 'history.dart';
import 'login.dart';
import 'nfcpage.dart';
import 'hcepage.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FareSeer - Home'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Status: Validated ',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => Profile(camera: widget.camera)),
                    );
                  },
                  child: Text('Profile'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => HCEpage(camera: widget.camera)),
                    );
                  },
                  child: Text('Pay'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => History(camera: widget.camera)),
                    );
                  },
                  child: Text('History'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    globals.id = null;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => Login(camera: widget.camera)),
                    );
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDartTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
