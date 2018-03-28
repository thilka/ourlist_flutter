import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsItem extends StatelessWidget {

  DetailsItem({Key key, @required this.text, @required this.callback});

  final text;
  final callback;

  @override
  Widget build(BuildContext context) {
    ListTile tile = new ListTile(title: new Text(text));
    return new Dismissible(
        key: new Key(text),
        child: tile,
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
        onDismissed: (DismissDirection direction) { callback(this); }
    );
  }
}