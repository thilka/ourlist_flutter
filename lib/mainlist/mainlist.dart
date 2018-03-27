import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/details/detailslist.dart';

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
          final String txt = widget.items[index];

          final listItem = new ListTile(
            title: new Text(
              "$txt",
              style: const TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _goToDetails(txt);
            },
          );

          return listItem;
        }
      },
    );

    return list;
  }

  void _goToDetails(String txt) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new DetailsList(name: txt);
        },
      )
    );
  }
}