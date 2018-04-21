import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ourlist_flutter/firebase/updatelistener.dart';
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

  Query ref;

  _DetailsListPageState(MainItem item) {
    ref = FirebaseDatabase.instance.reference()
        .child("items").equalTo(item.firebaseKey).orderByChild('project');

    new UpdateListener(ref, update);
  }

  final List<DetailsItem> items = [];

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
              var item = new DetailsItem(
                  text: value["name"],
                  checked: value["done"],
                  firebaseKey: key,
                  checkedCallback: _checkedCallback,
                  dismissCallback: _dismissItem);
              items.add(item);
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
      body: new DetailsList(items: items,
          addCallback: _addCallback, dismissCallback: _dismissItem),
    );
  }

  void _dismissItem(DetailsItem item) {
    ref.reference().child(item.firebaseKey).remove();
    items.remove(item);
    setState(() {});
  }

  void _addCallback(String input) {
    setState(() {
      debugPrint("Want to add " + input);
      ref.reference().push().set(<String, dynamic> {
        "name": input,
        "project": widget.item.firebaseKey,
        "done": false
      });
    });
  }

  void _checkedCallback(String firebaseKey, bool checked) {
    ref.reference().child(firebaseKey).update(<String, dynamic> {
      "done": checked
    });
  }
}