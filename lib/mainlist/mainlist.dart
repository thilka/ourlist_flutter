import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  @override
  createState() => new MainListState();
}

class MainListState extends State<MainList> {

  final _items = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {

    final list = new ListView.builder(
      padding: const EdgeInsets.all(2.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        if (index < _items.length) {
          final int txt = _items[index];
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