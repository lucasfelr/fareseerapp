import 'package:flutter/material.dart';
import 'appcontroller.dart';
import 'appcontroller.dart';
import 'appcontroller.dart';
import 'nfcpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String _counter = "", _value = "";
  int creditos = AppController.instance.creditos;

  Future _incrementCounter() async {
    setState(() {
      _value = _counter;
      print(_value);
      if (_value == "https://www.kaspersky.com") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Créditos: $creditos', style: TextStyle(fontSize: 20)),
            Container(
              height: 250,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seja bem vindo, Lucas'),
              ],
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_overscan),
        onPressed: _incrementCounter,
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
