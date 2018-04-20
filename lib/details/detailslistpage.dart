import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
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


class _DetailsListPageState extends State<DetailsListPage> with StreamSubscriberMixin<Event> {

  var ref;

  _DetailsListPageState(Query query) {
    ref = query;

    _registerListeners();
  }

  void _registerListeners() {
    listen(ref.onChildAdded, _update);
    listen(ref.onChildRemoved, _update);
    listen(ref.onChildChanged, _update);
    listen(ref.onChildMoved, _update);
  }

  final List<String> items = [];

  void _update(Event event) {
    setState(() {
      items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    if (items.isEmpty) {
      ref.once().then((snapshot) {
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
