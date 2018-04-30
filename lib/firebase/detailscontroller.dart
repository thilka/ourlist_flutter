import 'package:firebase_database/firebase_database.dart';
import 'package:ourlist_flutter/details/detailsitem.dart';
import 'package:ourlist_flutter/firebase/updatelistener.dart';

typedef UpdateCallback();
typedef LoadingCompleted(List<DetailsItem> items);

class DetailsController {

  Query _ref;
  UpdateListener _updateListener;
  String _parentFirebaseKey;

  DetailsController(this._parentFirebaseKey, UpdateCallback updateCallback) {
    _ref = FirebaseDatabase.instance.reference()
        .child("items").equalTo(_parentFirebaseKey).orderByChild('project');
    _updateListener = new UpdateListener(_ref, updateCallback);
  }

  void loadItems(LoadingCompleted loadingCompleted) {
    _ref.once().then((snapshot) {
        final List<DetailsItem> items = [];
        Map<dynamic, dynamic> map = snapshot.value;
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
        loadingCompleted(items);
    });
  }

  void add(String input) {
    if (input == null || input.isEmpty) {
      return;
    }
    _ref.reference().push().set(<String, dynamic> {
      "name": input,
      "project": _parentFirebaseKey,
      "done": false
    });
  }

  void _dismissItem(DetailsItem item) {
    _ref.reference().child(item.firebaseKey).remove();
  }

  void _checkedCallback(String firebaseKey, bool checked) {
    _ref.reference().child(firebaseKey).update(<String, dynamic> {
      "done": checked
    });
  }

  void deregister() {
    _updateListener.cancelSubscriptions();
  }
}