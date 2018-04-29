import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/firebase/detailscontroller.dart';
import 'detailslist.dart';
import 'detailsitem.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

class DetailsListPage extends StatefulWidget {
  DetailsListPage({Key key, @required this.item}) : super(key: key);

  final MainItem item;

  @override
  createState() {
    return new _DetailsListPageState(item);
  }
}

class _DetailsListPageState extends State<DetailsListPage> {

  DetailsController controller;
  _DetailsListPageState(MainItem item) {
    controller = new DetailsController(item.firebaseKey, update);
  }

  final List<DetailsItem> items = [];

  void update() {
    items.clear();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    _loadItemsIfNecessary();

    String text = widget.item.name;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
      ),
      body: new DetailsList(items: items, addCallback: _addCallback),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.deregister();
  }

  void _loadItemsIfNecessary() {
    if (items.isEmpty) {
      controller.loadItems(_loadingCompleted);
    }
  }

  void _loadingCompleted(List<DetailsItem> loadedItems) {
    setState(() {
      items.addAll(loadedItems);
      items.sort((a, b) {
        return a.text.toLowerCase().compareTo(b.text.toLowerCase());
      });

    });
  }

  void _addCallback(String input) {
    controller.add(input);
  }
}