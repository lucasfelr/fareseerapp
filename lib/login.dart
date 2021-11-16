import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ola_mundo/homepage.dart';
import 'globals.dart' as globals;
import 'nfcpage.dart';
import 'register.dart';
import 'package:postgres/postgres.dart';

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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Invalid Username or Password'),
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
                    List<
                        List<
                            dynamic>> results = await globals.connection.query(
                        "SELECT id FROM users WHERE username = @aValue and password = @bvalue",
                        substitutionValues: {
                          "aValue": user,
                          "bvalue": password
                        });

                    for (final row in results) {
                      globals.id = row[0];
                    }
                    if (globals.id == null) {
                      _showMyDialog();
                    } else {
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
