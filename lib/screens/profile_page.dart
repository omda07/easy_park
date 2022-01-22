import 'package:EasyPark/Models/fade_animation.dart';
import 'package:EasyPark/Models/loading.dart';
import 'package:EasyPark/api/database.dart';
import 'package:EasyPark/localization/demo_localization.dart';
import 'package:EasyPark/provider/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/about_me.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: AboutMe(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
//    final AuthService _auth = AuthService();
    User user = Provider.of<User>(context);
    return StreamBuilder<User>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return new Scaffold(
            body: FadeAnimation(
              1.4,
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),

                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.dlpng.com/static/png/1647142-profilepng-512512-profile-png-512_512_preview.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ],
                        ),
                      ),

                      SizedBox(height: 50.0),
                      Text(
                        user.displayName,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        user.email,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        user.phoneNumber,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
//                    Card(
//                      margin: EdgeInsets.only(
//                          top: 8, bottom: 8, right: 15, left: 15),
//                      child: Padding(
//                        padding: EdgeInsets.all(8),
//                        child: ListTile(
//                          leading: Icon(Icons.payment),
//                          title: Text('Payment Method'),
//                          onTap: () {
//                            Navigator.of(context).pushReplacementNamed('/');
//                          },
//                        ),
//                      ),
//                    ),
//                    Card(
//                      margin: EdgeInsets.only(
//                          top: 8, bottom: 8, right: 15, left: 15),
//                      child: Padding(
//                        padding: EdgeInsets.all(8),
//                        child: ListTile(
//                          leading: Icon(Icons.phone),
//                          title: Text('Contact us'),
//                          onTap: () {
//                            Navigator.of(context).pushReplacementNamed('/');
//                          },
//                        ),
//                      ),
//                    ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: ButtonTheme(
                          minWidth: 200,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            color: Colors.purple,
                            padding: EdgeInsets.all(10.0),
                            onPressed: () => _showSettingsPanel(),
                            child: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue("edit_profile"),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

//                          ButtonTheme(
//                            minWidth: 150,
//                            child: RaisedButton(
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(30),
//                              ),
//                              elevation: 4,
//                              color: Colors.red,
//                              padding: EdgeInsets.all(10.0),
//                              onPressed: () async {
//                                await _auth.signOut();
//                              },
//                              child: Text(
//                                'LogOut',
//                                style: TextStyle(color: Colors.white),
//                              ),
//                            ),
//                          ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Loading(),
          );
        }
      },
    );
  }
}
