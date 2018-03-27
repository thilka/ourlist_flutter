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

  var _items = [1, 2, 3, 4, 5];

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
          child: new MainList(items: _items),
        )
    );
  }

  void _addItem() {
    setState(() {
      _items.add(_items.length + 1);
    });
  }
}