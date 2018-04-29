import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourlist_flutter/firebase/maincontroller.dart';
import 'package:ourlist_flutter/mainlist/addmainitem.dart';
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

  final List<MainItem> _mainItems = [];

  MainController mainController;

  OurListAppState() {
    mainController = new MainController(update);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _signInAnonymously() async {
    final FirebaseUser user = await _auth.signInAnonymously();
    return 'signInAnonymously succeeded: $user';
  }

  @override
  void initState() {
    super.initState();

    _signInAnonymously().then((message) {
      debugPrint(message);
      mainController.loadItems(loadingCompleted);
    });
  }

  void update() {
    _mainItems.clear();
    setState(() { });
  }

  void _loadItemIfNecessary() {
    if (_mainItems.isEmpty) {
      mainController.loadItems(loadingCompleted);
    }
  }

  void loadingCompleted(List<MainItem> items) {
    setState(() {
      _mainItems.addAll(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadItemIfNecessary();
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
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return new AddMainItem(addCallback: _addItemCallback);
          },
        )
    );
  }

  void _addItemCallback(MainItem item) {
    mainController.addItem(item);
  }


  void _removeItem(MainItem item) {
    mainController.removeItem(item);
  }
}