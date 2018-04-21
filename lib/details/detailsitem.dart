import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void CheckedCallback(String firebaseKey, bool checked);

class DetailsItem extends StatelessWidget {
  DetailsItem({Key key,
    @required this.firebaseKey, @required this.text, @required this.checked,
    @required this.checkedCallback, @required this.dismissCallback});

  final firebaseKey;
  final text;
  final bool checked;
  final CheckedCallback checkedCallback;
  final dismissCallback;

  @override
  Widget build(BuildContext context) {

    Widget tile = new Container(
      child: new ListTile(
        title: new Text(text),
        leading: new Checkbox(value: checked, onChanged: _onValueChanged),
        onTap: () { _onValueChanged(!checked); },
      ),
      color: checked ? Colors.lightGreen : null,
    );
    return new Dismissible(
        key: new Key(text),
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
        onDismissed: (DismissDirection direction) { dismissCallback(this); }
    );
  }

  void _onValueChanged(bool newValue) {
    checkedCallback(firebaseKey, newValue);
  }
}