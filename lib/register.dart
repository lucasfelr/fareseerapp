import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ola_mundo/camera.dart';
import 'package:ola_mundo/camera.dart' as foto;
import 'login.dart';
import 'globals.dart' as globals;
import 'package:dio/dio.dart';

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
  String name = '';
  String user = '';
  String password = '';
  String passwordconf = '';
  final _textn = TextEditingController();
  final _textu = TextEditingController();
  final _textp = TextEditingController();
  final _textpc = TextEditingController();
  final _textd = TextEditingController();
  var response;
  bool _validaten = false;
  bool _validateu = false;
  bool _validatep = false;
  bool _validatepc = false;
  bool _validated = false;
  var dio = Dio();
  var date;
  var image;
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
                RichText(
                  text: TextSpan(
                    text: 'Please, take the photo first',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(camera: widget.camera)),
                    );
                  },
                  child: Text('Photo'),
                ),
                SizedBox(height: 15),
                TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  controller: _textn,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    errorText: _validaten ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    user = text;
                  },
                  controller: _textu,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    errorText: _validateu ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                    onChanged: (text) {
                      password = text;
                    },
                    controller: _textp,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _validatep ? 'Value Can\'t Be Empty' : null,
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true),
                TextField(
                    onChanged: (text) {
                      passwordconf = text;
                    },
                    controller: _textpc,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText: _validatepc ? 'Value Can\'t Be Empty' : null,
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true),
                TextField(
                  onChanged: (text) {
                    date = text;
                  },
                  controller: _textd,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Birth Date (DD-MM-AAAA)',
                    errorText: _validated ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: false,
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () async {
                    setState(() {
                      _textn.text.isEmpty
                          ? _validaten = true
                          : _validaten = false;
                      _textu.text.isEmpty
                          ? _validateu = true
                          : _validateu = false;
                      _textp.text.isEmpty
                          ? _validatep = true
                          : _validatep = false;
                      _textpc.text.isEmpty
                          ? _validatepc = true
                          : _validatepc = false;
                      _textd.text.isEmpty
                          ? _validated = true
                          : _validated = false;
                    });
                    if (password != passwordconf)
                      _showMyDialog("The Password does not match");
                    else if (foto.imageglob != null) {
                      image = Image.file(io.File(foto.imageglob));
                      var credentials = FormData.fromMap({
                        "avatar": await MultipartFile.fromFile(foto.imageglob,
                            filename: 'avatar.jpg'),
                        "name": name,
                        "username": user,
                        "password": password,
                        "birth_date": date
                      });
                      try {
                        response = await dio.post(globals.url + 'users',
                            data: credentials,
                            options: Options(headers: {
                              Headers.acceptHeader: 'application/json',
                              Headers.contentTypeHeader: 'multipart/form-data'
                            }));
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Login(camera: widget.camera)),
                        );
                      } on DioError catch (e) {
                        if (e.response!.data["message"] ==
                            "Internal server error")
                          _showMyDialog("All fields must be completed");
                        else
                          _showMyDialog(e.response!.data["message"] ?? "Erro");
                      }
                    } else {
                      _showMyDialog("A photo must be taken");
                    }
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
