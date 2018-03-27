import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DetailsList extends StatefulWidget {
  DetailsList({Key key, @required this.name}) : super(key: key);

  final name;

  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  @override
  Widget build(BuildContext context) {
    final tiles = [
      new ListTile(title: new Text("ONe")),
      new ListTile(title: new Text("Two")),
    ];

    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    String text = widget.name;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
      ),
      body: new ListView(children: divided),
    );
  }

}