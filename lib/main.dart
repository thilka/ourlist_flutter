import 'package:flutter/material.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  var _items = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'OurList',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('OurList'),
        ),
        body: new Center(
          child: new MainList(items: _items),
        ),
      ),
    );
  }
}