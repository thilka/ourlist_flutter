import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ourlist_flutter/firebase/updatelistener.dart';
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

final reference = FirebaseDatabase.instance.reference();

class OurListAppState extends State<OurListApp> {

  final List<MainItem> _mainItems = [];

  OurListAppState() {
    // register for change events
    new UpdateListener(reference, _fetchData);
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() async {
    DataSnapshot response = await reference.once();
    setState(() {
      _mainItems.clear();
      Map<String, dynamic> map = response.value["projects"];
      map.forEach((key, value) {
        _mainItems.add(new MainItem(key, value["name"]));
      });
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