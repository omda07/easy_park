import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Park with ChangeNotifier {
  String id;
  String name;
  String price;
  double duration;
  String capacity;
  String imageUrl;
  String description;
  String location;
  String parkDuration;
  bool isFavorite;
  GeoPoint locationm;

  Park();

  Park.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    price = data['price'];
    duration = data['duration'];
    capacity = data['space'];
    imageUrl = data['imageUrl'];
    description = data['description'];
    location = data['location'];
    parkDuration = data['timeTable'];
    locationm = data['locationm'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'duration': duration,
      'space': capacity,
      'description': description,
      'location': location,
      'timeTable': parkDuration,
      'loactionm': locationm,
    };
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

//  void _setFavValue(bool newValue) {
//    isFavorite = newValue;
//    notifyListeners();
//  }
}
