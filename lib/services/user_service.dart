import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData<T> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final String collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    User _user;
    _authenticationService.authState.listen(
      (User user) {
        if (user != null) {
          _user = user;
        }
      },
    );
    if (_user != null) {
      Document<T> doc = Document<T>(path: '$collection/${_user.uid}');
      return doc.streamData();
    } else {
      return null;
    }
  }

  Future<T> getDocument() {
    User _user;
    _authenticationService.authState.listen(
      (User user) {
        if (user != null) {
          _user = user;
        }
      },
    );
    if (_user != null) {
      Document<T> doc = Document<T>(path: '$collection/${_user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    User _user;
    _authenticationService.authState.listen(
      (User user) {
        if (user != null) {
          _user = user;
        }
      },
    );
    if (_user != null) {
      Document<T> doc = Document<T>(path: '$collection/${_user.uid}');
      return doc.upsert(data);
    } else {
      return null;
    }
  }
}
