import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ourlist_flutter/items/item.dart';

typedef RemoveItemCallback(Item itemKey);

class DismissibleItem extends Dismissible {
  final Item item;
  final Widget tile;
  final RemoveItemCallback dismissItemCallback;

  DismissibleItem({@required this.item, @required this.tile, @required this.dismissItemCallback})
      : super(
          key: new Key(item.firebaseKey),
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
              color: Colors.red),
          onDismissed: (DismissDirection direction) {
            dismissItemCallback(item);
          },
        );
}
