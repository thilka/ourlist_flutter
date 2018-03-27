import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MainList extends StatefulWidget {
  MainList({Key key, @required this.items}) : super(key:key);

  final items;

  @override
  createState() => new MainListState();
}

class MainListState extends State<MainList> {

  @override
  Widget build(BuildContext context) {

    final list = new ListView.builder(
      padding: const EdgeInsets.all(2.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        if (index < widget.items.length) {
          final int txt = widget.items[index];

          final container = new Container(
            child: new Text(
              "Item $txt",
              style: const TextStyle(fontSize: 18.0),
            ),
            padding: const EdgeInsets.all(8.0),
          );

          return container;
        }
      },
    );

    return list;
  }
}