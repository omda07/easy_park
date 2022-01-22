import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  final uid;
  String displayName;
  String email;
  String phoneNumber;

  User({this.uid, this.displayName, this.email, this.phoneNumber});

//  @override
//  String toString() {
//    // TODO: implement toString
//    return 'User {uid:$uid,dispalyName:$displayName,email:$email}';
//  }

//  factory User.fromJson(Map<String,dynamic> json)=>User(uid: json['uid'],email: json['email'],displayName: json['displayName']);
  factory User.fromDocument(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data;
    return User(
        uid: documentSnapshot.documentID,
        displayName: data['displayName'],
        email: data['email'],
        phoneNumber: data['phoneNumber']);
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'displayName': displayName};

  static Future<User> fetch(String uid) async {
    var userDocument =
        await Firestore.instance.collection('users').document(uid).get();
    return User.fromDocument(userDocument);
  }
}
