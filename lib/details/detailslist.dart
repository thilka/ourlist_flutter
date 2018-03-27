import 'package:flutter/material.dart';

class DetailsList extends StatefulWidget {
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  @override
  Widget build(BuildContext context) {
    final tiles = [
      new ListTile(title: new Text("One")),
      new ListTile(title: new Text("Two")),
    ];

    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new ListView(children: divided);
  }

}