import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ola_mundo/homepage.dart';
import 'globals.dart' as globals;
import 'register.dart';
import 'package:postgres/postgres.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String user = '';
  String password = '';
  final storage = new LocalStorage('app.22c374c1.js');
  void setlocal(state, userData) {
    print("setting user data");
    print(userData);
    state["user"] = userData["user"];
    if (userData["token"] != "") {
      state["token"] = userData["token"];
    }
    if (userData["user"]["user_type"] == "ADMIN") {
      state["isAdmin"] = true;
    }
    storage.setItem("state", jsonEncode(state));
  }

  void clearstorage() {
    storage.deleteItem("state");
  }

  Future<void> _showMyDialog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FareSeer - Login'),
        actions: [
          CustomSwitch(),
        ],
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
                TextField(
                  onChanged: (text) {
                    user = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () async {
                    var response = await http.post(
                        Uri.parse(globals.url + 'session'),
                        headers: <String, String>{
                          'Content-Type': 'application/json'
                        },
                        body: jsonEncode({
                          "username": user,
                          "password": password,
                        }));

                    if (response.statusCode != 200) {
                      _showMyDialog("Invalid Username or Password");
                    } else {
                      var respj = jsonDecode(response.body);
                      globals.id = respj["user"]['id'];
                      globals.sus = respj["user"]['tag_suspicious'];
                      globals.fraud = respj["user"]['tag_fraud'];
                      globals.block = respj["user"]['blocked'];
                      setlocal(globals.state, respj);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(camera: widget.camera)),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              Register(camera: widget.camera)),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
