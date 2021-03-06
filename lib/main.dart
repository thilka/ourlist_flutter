import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourlist_flutter/firebase/maincontroller.dart';
import 'package:ourlist_flutter/items/item.dart';
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

  final List<Item> _mainItems = [];

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

  bool loading = false;
  void _loadItemIfNecessary() {
    if (_mainItems.isEmpty) {
      mainController.loadItems(loadingCompleted);
      loading = true;
    }
  }

  void loadingCompleted(List<Item> items) {
    setState(() {
      _mainItems.clear();
      _mainItems.addAll(items);
      _mainItems.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      loading = false;
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
          child: loading ?
            new CircularProgressIndicator() :
            new MainList(items: _mainItems, dismissItemCallback: _removeItem)
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

  void _addItemCallback(Item item) {
    mainController.addItem(item);
  }

  void _removeItem(Item item) {
    mainController.removeItem(item);
  }
}