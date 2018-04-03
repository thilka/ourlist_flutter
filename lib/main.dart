import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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

class MainItem {
  final String key;
  final String name;
  MainItem(this.key, this.name);
}

final reference = FirebaseDatabase.instance.reference();

class OurListAppState extends State<OurListApp> {

  final List<MainItem> _mainItems = [];

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() async {
    List<MainItem> items = [];

    DataSnapshot response = await reference.once();
    Map<String, dynamic> map = response.value["projects"];
    map.forEach((key, value) {
      items.add(new MainItem(key, value["name"]));
    });
    setState(() {
      _mainItems.addAll(items);

    });
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
      var i = (_mainItems.length + 1);
      _mainItems.add(new MainItem(i.toString(), i.toString()));
    });
  }

  void _removeItem(String item) {
    setState(() {
      _mainItems.remove(item);
    });
  }
}