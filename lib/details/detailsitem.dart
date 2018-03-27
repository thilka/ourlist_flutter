import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsItem extends StatelessWidget {

  DetailsItem({Key key, @required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    ListTile tile = new ListTile(title: new Text(text));
    return new Dismissible(
        key: new Key(text),
        direction: DismissDirection.endToStart,
        background: new Container(
          child: new Icon(Icons.delete),
          color: Colors.red,
        ),
        child: tile,
        onDismissed: null
    );
  }

}