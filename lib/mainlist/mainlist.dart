import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/details/detailslistpage.dart';
import 'package:ourlist_flutter/items/dismissibleitem.dart';
import 'package:ourlist_flutter/items/item.dart';

class MainItem extends Item {
  MainItem(firebaseKey, name) : super(firebaseKey: firebaseKey, name: name);
}

class MainList extends StatefulWidget {
  MainList({Key key, @required this.items, @required this.dismissItemCallback})
      : super(key:key);

  final List<Item> items;
  final dismissItemCallback;

  @override
  createState() => new MainListState();
}

class MainListState extends State<MainList> {

  @override
  Widget build(BuildContext context) {

    final list = new ListView.builder(
      padding: const EdgeInsets.all(2.0),
      itemBuilder: (context, i) {
        if (i < widget.items.length) {
          var item = widget.items[i];
          final String txt = item.name;

          final listItem = new ListTile(
            title: new Text(
              "$txt",
              style: const TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _goToDetails(item);
            },
          );

          return new DismissibleItem(item: item, tile: listItem,
              dismissItemCallback: widget.dismissItemCallback);
        }
      },
    );

    return list;
  }

  void _goToDetails(Item item) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new DetailsListPage(item: item);
        },
      )
    );
  }
}