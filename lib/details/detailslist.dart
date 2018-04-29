import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'detailsitem.dart';

typedef void AddCallback(String input);

class DetailsList extends StatefulWidget {
  DetailsList({Key key,
    @required this.items,
    @required this.addCallback,
    @required this.editMode,
  });

  final List<DetailsItem> items;
  final AddCallback addCallback;
  final bool editMode;
  @override
  createState() => new _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    final List<DetailsItemWidget> items = [];
    widget.items.forEach((detailsItem) {
      items.add(new DetailsItemWidget(detailsItem: detailsItem));
    });

    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: items,
    ).toList();

    var listView = new ListView(children: divided, controller: _scrollController,);

    if (widget.editMode) {
      divided.insert(0, createInputField);
      _scrollListToCorrectPositionForEnteringNewItem();
    }

    return listView;
  }

  ListTile get createInputField {
    return new ListTile(
      title: new TextField(
        autofocus: true,
        onSubmitted: _inputSubmitted,
      ),
    );
  }

  void _scrollListToCorrectPositionForEnteringNewItem() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _inputSubmitted(String input) {
    setState(() {
      widget.addCallback(input);
    });
  }
}