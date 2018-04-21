import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsItem extends StatefulWidget {
  DetailsItem({Key key, @required this.text, @required this.callback});

  final text;
  final callback;

  @override
  createState() => new DetailsItemState();
}

class DetailsItemState extends State<DetailsItem> {

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    Widget tile = new Container(
      child: new ListTile(
        title: new Text(widget.text),
        leading: new Checkbox(value: _checked, onChanged: _onValueChanged),
        onTap: () { _onValueChanged(!_checked); },
      ),
      color: _checked ? Colors.lightGreen : null,
    );
    return new Dismissible(
        key: new Key(widget.text),
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
        onDismissed: (DismissDirection direction) { widget.callback(widget); }
    );
  }

  void _onValueChanged(bool newValue) {
    setState(() {
      _checked = newValue;
    });
  }
}