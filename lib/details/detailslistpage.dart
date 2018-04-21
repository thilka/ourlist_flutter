import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/firebase/updatelistener.dart';
import 'detailslist.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';

class DetailsListPage extends StatefulWidget {
  DetailsListPage({Key key, @required this.item}) : super(key: key);

  final MainItem item;

  @override
  createState() {
    var ref = FirebaseDatabase.instance.reference()
        .child("items").equalTo(item.key).orderByChild('project');
    return new _DetailsListPageState(ref);
  }
}

class _DetailsListPageState extends State<DetailsListPage> {

  var ref;
  var updateListener;

  _DetailsListPageState(Query query) {
    ref = query;
    updateListener = new UpdateListener(query, update);
  }

  final List<String> items = [];

  void update() {
    setState(() {
      items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      ref.once().then((snapshot) {
        Map<String, dynamic> map = snapshot.value;
        setState(() {
          if (map != null) {
            map.forEach((key, value) {
              items.add(value["name"]);
            });
          }
        });
      });
    }

    String text = widget.item.name;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$text'),
      ),
      body: new DetailsList(items: items),
    );
  }
}