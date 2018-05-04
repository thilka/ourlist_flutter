import 'package:flutter/foundation.dart';


abstract class Item {
  Item({@required this.firebaseKey, @required this.name});

  final firebaseKey;
  final String name;
}