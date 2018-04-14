import 'package:firebase_database/firebase_database.dart';
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

final firebase = FirebaseDatabase.instance;

class _DetailsListPageState extends State<DetailsListPage> {

  final List<String> items = [];

  @override
  Widget build(BuildContext context) {

    if (items.isEmpty) {
      firebase.reference().child("items").once().then((snapshot) {
        setState(() {
          debugPrint(snapshot.toString());

          Map<String, dynamic> map = snapshot.value;
          map.forEach((key, value) {
            //debugPrint(key);
            //debugPrint(value.toString());
            if (value["project"] == widget.item.key) {
              items.add(value["name"]); // works!
            }
          });
        });
      });

      return new Container();
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
