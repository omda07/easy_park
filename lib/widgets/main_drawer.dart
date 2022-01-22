import 'package:EasyPark/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:EasyPark/provider/auth.dart';
import 'package:EasyPark/screens/profile_page.dart';

import 'contact_us.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    final AuthService _auth = AuthService();
    return Drawer(
      elevation: 4,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              DemoLocalization.of(context).getTranslatedValue("easy_park"),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
//          ListTile(
//            leading: Icon(
//              Icons.home,
//              color: Theme.of(context).primaryColor,
//            ),
//            title: Text('Home'),
//            onTap: () {
//              Navigator.of(context).pushReplacementNamed('/');
//            },
//          ),
//          Divider(),
//          ListTile(
//            leading: Icon(
//              Icons.book,
//              color: Theme.of(context).primaryColor,
//            ),
//            title: Text('Booking'),
//            onTap: () {
////              Navigator.of(context)
////                  .pushReplacementNamed(BookingScreen.routeName);
//            },
//          ),
//          Divider(),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            title: Text(
              DemoLocalization.of(context).getTranslatedValue("my_account"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ProfilePage.routeName);
            },
          ),
//          Divider(),
//          ListTile(
//            leading: Icon(
//              Icons.favorite,
//              color: Colors.red,
//            ),
//            title: Text('Favorite'),
//            onTap: () {
////              Navigator.of(context)
////                  .pushReplacementNamed(FavoriteItem.routeName);
//            },
          //      ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.green,
              size: 40,
            ),
            title: Text(
              DemoLocalization.of(context).getTranslatedValue("contact"),
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ContactUss.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: 40,
            ),
            title: Text(
              DemoLocalization.of(context).getTranslatedValue("logout"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () async {
              await _auth.signOut();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
