import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';

typedef FirebaseUpdateCallback();

class UpdateListener extends Object with StreamSubscriberMixin<Event> {
  final FirebaseUpdateCallback updateCallback;

  UpdateListener(Query query, this.updateCallback) {
    _registerListeners(query);
  }

  void _registerListeners(Query ref) {
    listen(ref.onChildAdded, _update);
    listen(ref.onChildRemoved, _update);
    listen(ref.onChildChanged, _update);
    listen(ref.onChildMoved, _update);
  }

  void _update(Event event) {
    updateCallback();
  }
}
