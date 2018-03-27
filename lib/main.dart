import 'package:flutter/material.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'OurList',
      home: new OurListApp()
    );
  }
}

class OurListApp extends StatefulWidget {
  @override
  createState() => new OurListAppState();
}

class OurListAppState extends State<OurListApp> {

  final _mainItems = ['Aldi', 'dm', 'Baumarkt'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('OurList'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.add, color: Colors.white,), onPressed: _addItem)
          ],
        ),
        body: new Center(
          child: new MainList(items: _mainItems),
        )
    );
  }

  void _addItem() {
    setState(() {
      _mainItems.add((_mainItems.length + 1).toString());
    });
  }
}