import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/park.dart';
class DetailsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final details=Provider.of<Park>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(details.name),

            subtitle:Text(details.location) ,
          ),
          Divider(),
          Column(
            children: <Widget>[
              Image.network(details.imageUrl,fit:BoxFit.cover,),
              Text('Description',style: TextStyle(fontSize: 24) ,),
              Text(details.description),


            ],
          ),
          Divider(),
          ListTile(
            title: Text('Car park timetable'),
            subtitle: Text(details.parkDuration),
          ),
          Column(
            children: <Widget>[
              Text('What our customers say'),
              Row(children: <Widget>[
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star_half),
                Icon(Icons.star_border),

              ],)
            ],
          ),
          Divider(),
        ],
      ),

    );
  }
}
