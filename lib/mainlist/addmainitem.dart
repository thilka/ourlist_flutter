import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/items/item.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

typedef MainItemAddedCallback(Item item);

class AddMainItem extends StatefulWidget {
  final addCallback;

  AddMainItem({@required this.addCallback});

  @override
  State<StatefulWidget> createState() => new MainItemState();
}

class MainItemState extends State<AddMainItem> {

  var input;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Item'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.check, color: Colors.white,),
            onPressed: () {
              _addItem();
              Navigator.pop(context);
          })
        ],
      ),
      body:
        new Container(
          child: new TextField(
            autofocus: true,
            onChanged: _inputChanged,
          ),
          padding: const EdgeInsets.all(16.0)
        )
    );
  }

  void _addItem() {
    widget.addCallback(new MainItem(null, input));
  }

  void _inputChanged(String value) {
    input = value;
  }
}