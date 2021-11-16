import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ola_mundo/camera.dart';
import 'package:ola_mundo/camera.dart' as foto;
import 'login.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FareSeer - Register'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => Login(camera: widget.camera)),
            );
          },
        ),
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
                    password = text;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    user = text;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Birth Date',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    //Registrar usuário no servidor
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(camera: widget.camera)),
                    );
                  },
                  child: Text('Photo'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    if (foto.imageglob != "")
                      var image = Image.file(File(foto.imageglob));
                    //Registrar usuário no servidor
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => Login(camera: widget.camera)),
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
