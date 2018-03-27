import 'package:flutter/material.dart';

class DetailsList extends StatefulWidget {
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {

  final _tiles = [
    createListTile("One"),
    createListTile("Two"),
  ];
  static Widget createListTile(String input) {
    ListTile tile = new ListTile(title: new Text(input));
  return new Dismissible(
      key: new Key(input),
      direction: DismissDirection.endToStart,
      background: new Container(
        child: new Icon(Icons.delete),
        color: Colors.red,
      ),
      child: tile,
      onDismissed: null
    );
  }

  var _editMode = false;

  @override
  Widget build(BuildContext context) {
    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: _tiles,
    ).toList();

    if (_editMode) {
      divided.add(createInputField);
    } else {
      divided.add(createAddButton);
    }

    return new ListView(children: divided);
  }

  ListTile get createInputField {
    return new ListTile(
      title: new TextField(
        autofocus: true,
        onSubmitted: _inputSubmitted,
      ),
    );
  }

  ListTile get createAddButton {
    return new ListTile(
      title: new IconButton(
        icon: new Icon(Icons.add),
        onPressed: _addItem,
        color: Colors.blue,
      ),
    );
  }

  void _addItem() {
    setState(() {
      _editMode = true;
    });
  }

  void _inputSubmitted(String input) {
    setState(() {
      _editMode = false;
      _tiles.add(createListTile(input));
    });
  }

}