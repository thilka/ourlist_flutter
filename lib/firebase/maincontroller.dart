import 'package:firebase_database/firebase_database.dart';
import 'package:ourlist_flutter/firebase/updatelistener.dart';
import 'package:ourlist_flutter/mainlist/mainlist.dart';


typedef UpdateCallback();
typedef LoadingCompleted(List<MainItem> items);

class MainController {

  final reference = FirebaseDatabase.instance.reference().child("projects");

  MainController(UpdateCallback updateCallback) {
    new UpdateListener(reference, updateCallback);
  }

  void loadItems(LoadingCompleted loadingCompleted) {

    reference.once().then((response) {
      List<MainItem> _mainItems = [];
      Map<dynamic, dynamic> map = response.value;
      map.forEach((key, value) {
        _mainItems.add(new MainItem(key, value["name"]));
      });
      loadingCompleted(_mainItems);
    });
  }

  void addItem(MainItem item) {
    reference.push().set(<String, dynamic> {
      "name": item.name,
      "created": new DateTime.now().millisecondsSinceEpoch
    });
  }

  void removeItem(MainItem item) {
    reference.child(item.firebaseKey).remove();
  }
}