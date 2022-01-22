import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:EasyPark/provider/park.dart';
import 'package:EasyPark/provider/park_details.dart';

final DocumentReference documentReference =
    Firestore.instance.document("easypark/garage");
final databaseReference = Firestore.instance;

getParkLoc(ParkDetails parkDetails) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('garage').getDocuments();

  List<GeoPoint> _parkListLoc = [];
  List<Park> _parkList = [];
  snapshot.documents.forEach((document) {
    Park park = Park.fromMap(document.data);
    _parkListLoc.add(park.locationm);
    _parkList.add(park);
  });
  parkDetails.parkList = _parkList;
  parkDetails.parkListLoc = _parkListLoc;
}
