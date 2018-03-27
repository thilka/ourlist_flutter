import 'package:flutter/material.dart';
import 'detailsitem.dart';

class DetailsList extends StatefulWidget {
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {

  final _tiles = [
    new DetailsItem(text: "One"),
    new DetailsItem(text: "Two"),
  ];

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
      _tiles.add(new DetailsItem(text: input));
    });
  }

}