import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void CheckedCallback(String firebaseKey, bool checked);

class DetailsItem {
  DetailsItem({
    @required this.firebaseKey, @required this.text, @required this.checked,
    @required this.checkedCallback, @required this.dismissCallback});

  final firebaseKey;
  final text;
  final checked;
  final checkedCallback;
  final dismissCallback;
}


class DetailsItemWidget extends StatelessWidget {
  DetailsItemWidget({Key key,
    @required this.detailsItem});

  final detailsItem;

  @override
  Widget build(BuildContext context) {

    Widget tile = new Container(
      child: new ListTile(
        title: new Text(detailsItem.text),
        leading: new Checkbox(value: detailsItem.checked, onChanged: _onValueChanged),
        onTap: () { _onValueChanged(!detailsItem.checked); },
      ),
      color: detailsItem.checked ? Colors.lightGreen : null,
    );
    return new Dismissible(
        key: new Key(detailsItem.text),
        child: tile,
        direction: DismissDirection.endToStart,
        background: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(''),
              ),
              new Icon(Icons.delete_forever, color: Colors.white),
            ],
          ),
          color: Colors.red
        ),
        onDismissed: (DismissDirection direction) { detailsItem.dismissCallback(this); }
    );
  }

  void _onValueChanged(bool newValue) {
    detailsItem.checkedCallback(detailsItem.firebaseKey, newValue);
  }
}