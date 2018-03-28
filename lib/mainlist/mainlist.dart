import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/details/detailslistpage.dart';

class MainList extends StatefulWidget {
  MainList({Key key, @required this.items, @required this.removeCallback}) : super(key:key);

  final List<String> items;
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
          final String txt = widget.items[i];

          final listItem = new ListTile(
            title: new Text(
              "$txt",
              style: const TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _goToDetails(txt);
            },
          );

          final dismissibleListItem = new Dismissible(
            key: new Key(txt),
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
              widget.removeCallback(txt);
            },
          );

          return dismissibleListItem;
        }
      },
    );

    return list;
  }

  void _goToDetails(String txt) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new DetailsListPage(name: txt);
        },
      )
    );
  }
}