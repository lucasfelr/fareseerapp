// @dart=2.9--no-sound-null-safety

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ola_mundo/camera.dart';
import 'package:postgres/postgres.dart';
import 'globals.dart' as globals;

import 'appwidget.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.last;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: AppWidget(camera: firstCamera),
    ),
  );
}
