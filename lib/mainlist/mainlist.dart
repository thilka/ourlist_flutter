import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  @override
  createState() => new MainListState();
}

class MainListState extends State<MainList> {

  @override
  Widget build(BuildContext context) {

    final list = new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        if (index < 20) {
          final text = new Text(
            "$index",
            style: const TextStyle(fontSize: 18.0),
          );
          return text;
        }
      },
    );

    return list;
  }
}