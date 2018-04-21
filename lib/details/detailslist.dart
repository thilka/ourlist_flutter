import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'detailsitem.dart';

class DetailsList extends StatefulWidget {
  DetailsList({Key key, @required this.items, @required this.dismissCallback});

  final List<DetailsItem> items;
  final dismissCallback;
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {

  final ScrollController _scrollController = new ScrollController();

  var _editMode = false;

  @override
  Widget build(BuildContext context) {

    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: widget.items,
    ).toList();

    if (_editMode) {
      divided.add(createInputField);
    } else {
      divided.add(createAddButton);
    }

    return new ListView(children: divided, controller: _scrollController,);
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
      _scrollListToCorrectPositionWhenKeyboardAppears();
    });
  }

  void _scrollListToCorrectPositionWhenKeyboardAppears() {
    final approxKeyboardHeight = 300;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + approxKeyboardHeight,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _inputSubmitted(String input) {
    setState(() {
      _editMode = false;
      widget.items.add(new DetailsItem(text: input, callback: widget.dismissCallback));
    });
  }
}