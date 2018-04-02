import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

void main() => runApp(new MyApp());

final reference = FirebaseDatabase.instance.reference();

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
  void initState() {
    super.initState();
    reference.once()
        .then(
          (DataSnapshot snapshot) {
            debugPrint(snapshot.toString());
          }
        );
  }

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
          child: new MainList(items: _mainItems, removeCallback: _removeItem),
        )
    );
  }

  void _addItem() {
    setState(() {
      _mainItems.add((_mainItems.length + 1).toString());
    });
  }

  void _removeItem(String item) {
    setState(() {
      _mainItems.remove(item);
    });
  }
}