import 'dart:collection';
import 'package:EasyPark/classes/language.dart';
import 'package:EasyPark/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:EasyPark/api/park_api.dart';
import 'package:EasyPark/provider/park_details.dart';
import 'package:EasyPark/screens/garage_details_screen.dart';
import 'package:EasyPark/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main-page';

  @override
  _MainPageState createState() => _MainPageState();
}

typedef Marker MarkerUpdateAction(Marker marker);

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  static LatLng _initialPosition;
  bool mapToggle = false;
  bool clientsToggle = false;

  Set<Marker> _markers = HashSet<Marker>();
  MarkerId selectedMarker;

  static LatLng center;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ParkDetails parkDetails;

  @override
  initState() {
    super.initState();
    parkDetails = Provider.of<ParkDetails>(context, listen: false);
    getParkLoc(parkDetails);

    // _markers;
    _onMapCreated(_mapController);
    _getUserLocation();
  }

  GoogleMapController _mapController;
  String searchAddr;

  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'EG');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
//    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(lang.name),
                              Text(lang.flag),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (Language language) {
                  _changeLanguage(language);
                }),
          )
        ],
        elevation: 3,
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: _initialPosition == null
            ? Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 80.0,
                    color: Colors.purple),
              )
            : Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 15.0),
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    markers: Set<Marker>.of(_markers),
                  ),
                  Positioned(
                    top: 60.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: _searchandNavigate,
                              iconSize: 30.0),
                        ),
                        onChanged: (val) {
                          setState(() {
                            searchAddr = val;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _markers.clear();
    try {
      setState(() {
        for (int i = 0; i < parkDetails.parkListLoc.length; i++) {
          print(parkDetails.parkList[i].name);

          final String markerIdVal = parkDetails.parkList[i].name;

          final MarkerId markerId = MarkerId(markerIdVal);

          _markers.add(
            Marker(
              markerId: markerId,
              position: LatLng(parkDetails.parkListLoc[i].latitude.toDouble(),
                  parkDetails.parkListLoc[i].longitude.toDouble()),
              onTap: () {
//              showBottomSheet(context: context, builder: (builder){
//                return Container(
//                  child: Text(parkDetails.parkList[i].id.toString()),
//                );
//              });
                setState(() {
                  print(parkDetails.parkList[i].name);
                  Navigator.of(context).pushNamed(GarageDetailsScreen.routeName,
                      arguments: parkDetails.parkList[i].name);
                });
              },
              infoWindow: InfoWindow(
                title: markerIdVal,
                snippet: parkDetails.parkList[i].price.toString(),
              ),
            ),
          );
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  void _getUserLocation() async {
    print('here');
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _initialPosition = LatLng(position.latitude, position.longitude);
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  void _searchandNavigate() async {
    try {
      await Geolocator().placemarkFromAddress(searchAddr).then((result) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    result[0].position.latitude, result[0].position.longitude),
                zoom: 15.0)));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }
}
