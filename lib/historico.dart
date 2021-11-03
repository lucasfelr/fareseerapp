import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'nfcpage.dart';

class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Tile(text: Text("a")),
        Tile(text: Text("b")),
        Tile(text: Text("c")),
      ],
    ));
  }
}

int count = 0;
List<History> historyList = [];

class History {
  String data;
  DateTime dateTime;

  History({required this.data, required this.dateTime});
}

class Tile extends StatefulWidget {
  final Text text;
  Tile({required this.text});

  @override
  TileState createState() => TileState();
}

class TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.text,
      onTap: () {
        count++;
        print(count);
        historyList.add(History(data: "", dateTime: DateTime.now()));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(),
            ));
      },
    );
  }
}

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                ' ${historyList[index].data}   ${historyList[index].dateTime.toString()}'),
          );
        },
      ),
    );
  }
}
