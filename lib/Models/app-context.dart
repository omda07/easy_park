import 'dart:async';

import 'package:EasyPark/provider/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/auth.dart';

class AppContext extends ChangeNotifier {
  AuthService _auth = AuthService();
  StreamController<User> _onUserChanged = StreamController();

  AppContext() {
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async {
      if (firebaseUser != null) {
        try {
          User user = await User.fetch(firebaseUser.uid);
          _onUserChanged.sink.add(user);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
      } else {
       // _onUserChanged.sink.add();
      }
    });
  }

  @override
  void dispose() {
    _onUserChanged.close();
    // TODO: implement dispose
    super.dispose();
  }

  Stream<User> get onUserChanged => _onUserChanged.stream;
  Future<String> signUp(String displayName, String email, String password) {
    return _auth.registerWithEmailAndPassword(displayName, email, password);
  }

  Future<String> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut(String email, String password, String displayName) {
    return _auth.signOut();
  }
}
