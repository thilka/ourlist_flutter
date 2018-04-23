import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/details/detailslistpage.dart';

class MainItem {
  final String firebaseKey;
  final String name;
  MainItem(this.firebaseKey, this.name);
}

typedef RemoveItemCallback(MainItem itemKey);

class MainList extends StatefulWidget {
  MainList({Key key, @required this.items, @required this.removeCallback}) : super(key:key);

  final List<MainItem> items;
  final removeCallback;

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

          Dismissible dismissibleListItem = _wrapInDismissibleItem(
              item, listItem, widget.removeCallback);

          return dismissibleListItem;
        }
      },
    );

    return list;
  }

  Dismissible _wrapInDismissibleItem(MainItem item, ListTile listItem,
      RemoveItemCallback removeItemCallback) {
    final dismissibleListItem = new Dismissible(
      key: new Key(item.firebaseKey),
      child: listItem,
      direction: DismissDirection.endToStart,
      background: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(''),
              ),
              new Icon(Icons.delete_forever, color: Colors.white),
            ],
          ),
          color: Colors.red
      ),
      onDismissed: (DismissDirection direction) {
        removeItemCallback(item);
      },
    );
    return dismissibleListItem;
  }

  void _goToDetails(MainItem item) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new DetailsListPage(item: item);
        },
      )
    );
  }
}