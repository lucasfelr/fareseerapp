import 'package:flutter/material.dart';
import 'package:ola_mundo/webview.dart';
import 'appcontroller.dart';
import 'cadastrar.dart';
import 'nfcpage.dart';

class AppWidget extends StatelessWidget {
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
          home: Cadastrar(),
        );
      },
    );
  }
}
