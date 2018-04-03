import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'detailslist.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

class DetailsListPage extends StatefulWidget {
  DetailsListPage({Key key, @required this.item}) : super(key: key);

  final MainItem item;

  @override
  createState() => new _DetailsListPageState();
}

class _DetailsListPageState extends State<DetailsListPage> {
  @override
  Widget build(BuildContext context) {

    String text = widget.item.name;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
      ),
      body: new DetailsList(),
    );
  }
}
