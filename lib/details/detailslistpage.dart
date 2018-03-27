import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'detailslist.dart';

class DetailsListPage extends StatefulWidget {
  DetailsListPage({Key key, @required this.name}) : super(key: key);

  final name;

  @override
  createState() => new _DetailsListPageState();
}

class _DetailsListPageState extends State<DetailsListPage> {
  @override
  Widget build(BuildContext context) {

    String text = widget.name;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
      ),
      body: new DetailsList(),
    );
  }
}
