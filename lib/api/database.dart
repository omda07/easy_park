import 'package:EasyPark/provider/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;
  Database({required this.uid});

  // collection reference
  final CollectionReference parkCollection =
      Firestore.instance.collection('garage');
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(
      String displayName, String email, String phoneNumber) async {
    return await usersCollection.document(uid).setData({
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    });
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        displayName: snapshot.data['displayName'],
        email: snapshot.data['email'],
        phoneNumber: snapshot.data['phoneNumber']);
  }

  Stream<User> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get brews {
    return parkCollection.snapshots();
  }
}
