import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/park_details.dart';

class GarageDetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';

  @override
  _GarageDetailsScreen createState() => _GarageDetailsScreen();
}

class _GarageDetailsScreen extends State<GarageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // final parkDetail = Provider.of<ParkDetails>(context);
    //final detail = parkDetail.items;
    final parkId = ModalRoute.of(context).settings.arguments as String;
    // dh b2a ya ba4a b find id w yrg3hole

    final loadedPark =
        Provider.of<ParkDetails>(context, listen: false).findById(parkId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true)),
        title: Text(loadedPark.name),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(loadedPark.name),
                subtitle: Text('''${loadedPark.location}

Free Space: ${loadedPark.capacity}
Price per hour: ${loadedPark.price}'''),
              ),

//              Text('',textAlign: TextAlign.start,),
//              Text(''),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Book now',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple,
              ),
              Divider(),

              Column(
                children: <Widget>[
                  Image.network(
                    loadedPark.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(
                      'Description',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(loadedPark.description),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                title: Text('Car park timetable'),
                subtitle: Text(loadedPark.parkDuration),
              ),
              Divider(),
              Column(
                children: <Widget>[
                  Text('What our customers say'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star_half),
                      Icon(Icons.star_border),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      labelText: "FeedBack",
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.purple,

//      onSaved: (String value) {
//        _user.displayName = value;
//      },
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
