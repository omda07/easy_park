import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState with ChangeNotifier {
  bool locationServiceActive = true;
  static LatLng _initialPosition;

  AppState() {
    _getUserLocation();
    _loadingInitialPosition();
  }
// ! TO GET THE USERS LOCATION

  void _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _initialPosition = LatLng(position.latitude, position.longitude);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }
  // ! TO CREATE ROUTE

//  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(milliseconds: 200)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}
