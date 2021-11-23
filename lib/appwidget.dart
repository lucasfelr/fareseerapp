import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ola_mundo/camera.dart';
import 'appcontroller.dart';
import 'login.dart';
import 'camera.dart';
import 'main.dart' as main;

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.red,
              brightness: AppController.instance.isDartTheme
                  ? Brightness.dark
                  : Brightness.light,
            ),
            home: Login(camera: camera));
      },
    );
  }
}
