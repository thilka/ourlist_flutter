import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ourlist_flutter/items/dismissibleitem.dart';
import 'package:ourlist_flutter/items/item.dart';

typedef void CheckedCallback(String firebaseKey, bool checked);

class DetailsItem extends Item {
  DetailsItem({@required firebaseKey, @required name,
    @required this.checked, @required this.checkedCallback, @required this.dismissCallback}) : super(firebaseKey: firebaseKey, name: name);

  final checked;
  final checkedCallback;
  final dismissCallback;
}

class DetailsItemWidget extends StatelessWidget {
  DetailsItemWidget({Key key,
    @required this.detailsItem});

  final DetailsItem detailsItem;

  @override
  Widget build(BuildContext context) {

    Widget tile = new Container(
      child: new ListTile(
        title: new Text(detailsItem.name),
        leading: new Checkbox(value: detailsItem.checked, onChanged: _onValueChanged),
        onTap: () { _onValueChanged(!detailsItem.checked); },
      ),
      color: detailsItem.checked ? Colors.lightGreen : null,
    );
    return new DismissibleItem(item: detailsItem, tile: tile, dismissItemCallback:detailsItem.dismissCallback);
  }

  void _onValueChanged(bool newValue) {
    detailsItem.checkedCallback(detailsItem.firebaseKey, newValue);
  }
}