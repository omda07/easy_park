import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './park.dart';
//import 'package:http/http.dart' as http;

//import '../Models/http_exception.dart';

class  ParkDetails with ChangeNotifier {
  List<Park> _items = [];
  List<GeoPoint>_loc=[];

  Park _currentPark;

  UnmodifiableListView<Park> get parkList  =>  UnmodifiableListView(_items);
  UnmodifiableListView<GeoPoint> get parkListLoc => UnmodifiableListView(_loc);

  Park get currentPark => _currentPark;

  set parkList(List<Park> parkList) {
    _items = parkList;
    notifyListeners();
  }

  set currentPark(Park park) {
    _currentPark = park;
    notifyListeners();
  }
  set parkListLoc(List<GeoPoint> parkListLoc) {
    _loc = parkListLoc;
    notifyListeners();
  }

  findById(String parName) {
return parkList.firstWhere((par)=>par.name ==parName);
  }
}
