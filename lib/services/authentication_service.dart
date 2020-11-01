import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDb =
      FirebaseFirestore.instance; //TODO: Write data to firestore

//USER
  Stream<User> get authState => _firebaseAuth.authStateChanges();

//TODO: does this work?
  Future<void> updateUserData(UserCredential userCredential) {
    final User user = userCredential.user;
    DocumentReference reportRef =
        _firebaseDb.collection('Nutzer').doc(user.uid);

    return reportRef.set({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'creationTime': user.metadata.creationTime,
      'lastSignInTime': user.metadata.lastSignInTime,
      'signInMethod': userCredential.credential.signInMethod,
    }, SetOptions(merge: true));
  }

  Future<void> updateName(personalData, User user) {
    DocumentReference reportRef =
        _firebaseDb.collection('Nutzer').doc(user.uid);

    return reportRef.set({
      'Vorname': personalData[0],
      'Nachname': personalData[1],
      'Email': personalData[2],
    }, SetOptions(merge: true));
  }

  Future logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      return error.message;
    }
  }

//EMAIL

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      updateUserData(userCredential);
      return userCredential.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      updateUserData(userCredential);
      return userCredential.user != null;
    } catch (e) {
      return e.message;
    }
  }

//APPLE SIGN IN

  // Determine if Apple SignIn is available
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  /// Sign in with Apple
  Future appleSignIn() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        // handle errors from Apple here
      }

      final AuthCredential credential =
          OAuthProvider('apple.com').getCredential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      await updateUserData(userCredential);
      return userCredential.user != null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}

/*
authState.listen((User user) { })
Future appleSignIn() async {
    final AuthorizationResult appleResult = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (appleResult.status) {
      case AuthorizationStatus.authorized:

        // UpdateUserdata

        break;

      case AuthorizationStatus.error:
        print("Sign in failed: ${appleResult.error.localizedDescription}");

        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
  }
*/
