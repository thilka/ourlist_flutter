import 'package:flutter/material.dart';
import 'detailsitem.dart';

class DetailsList extends StatefulWidget {
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {

  _DetailsListState() {
    _tiles.add(new DetailsItem(text: "One", callback: _dismissItem));
    _tiles.add(new DetailsItem(text: "Two", callback: _dismissItem));
  }

  final List<DetailsItem> _tiles = [];


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
      _tiles.add(new DetailsItem(text: input, callback: _dismissItem));
    });
  }

  void _dismissItem(DetailsItem item) {
    _tiles.remove(item);
    setState(() {});
  }
}