import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'nfcpage.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  String email = '';
  String password = '';
  String aux = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    aux = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    globals.criancas[globals.iterador] = aux;
                    globals.criancasValue[globals.iterador] = false;
                    globals.iterador = (globals.iterador + 1) % 4;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
