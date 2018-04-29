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

  bool refreshNecessary = true;
  DetailsController controller;
  _DetailsListPageState(MainItem item) {
    controller = new DetailsController(item.firebaseKey, update);
  }

  final List<DetailsItem> items = [];
  var editMode = false;

  void update() {
    refreshNecessary = true;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    _loadItemsIfNecessary();

    String text = widget.item.name;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add, color: Colors.white,), onPressed: _addItem)
        ],
      ),
      body: new Center(
          child: loading ?
            new CircularProgressIndicator() :
            new DetailsList(items: items, addCallback: _addCallback, editMode: editMode)
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.deregister();
  }

  bool loading = false;

  void _loadItemsIfNecessary() {
    if (refreshNecessary) {
      controller.loadItems(_loadingCompleted);
      loading = true;
    }
  }

  void _loadingCompleted(List<DetailsItem> loadedItems) {
    setState(() {
      items.clear();
      items.addAll(loadedItems);
      items.sort((a, b) {
        return a.text.toLowerCase().compareTo(b.text.toLowerCase());
      });
      loading = false;
      refreshNecessary = false;
    });
  }

  void _addItem() {
    setState(() {
      editMode = true;
    });
  }

  void _addCallback(String input) {
    controller.add(input);
    editMode = false;
  }
}