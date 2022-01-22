import 'package:EasyPark/Models/fade_animation.dart';
import 'package:EasyPark/api/database.dart';
import 'package:EasyPark/localization/demo_localization.dart';
import 'package:EasyPark/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutMe extends StatefulWidget {
  static const routeName = '/about-me';

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  String displayName = '';
  String emailAdd = '';

  String phoneNumber = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Profile settings.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle,
                          size: 40, color: Theme.of(context).primaryColor),
//        fillColor: Color(0xfff3f3f4),
                      //  filled: true,
                      labelText: DemoLocalization.of(context)
                          .getTranslatedValue("display_name"),
                      labelStyle: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    initialValue: userData.displayName,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => displayName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.email,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email,
                          size: 40, color: Theme.of(context).primaryColor),
//        fillColor: Color(0xfff3f3f4),
                      //    filled: true,
                      labelText: DemoLocalization.of(context)
                          .getTranslatedValue("email"),
                      hintText: 'Enter your Email',
                      labelStyle: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.purple,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      }

                      if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    onChanged: (val) => setState(() => emailAdd = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.phoneNumber,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone,
                          size: 40, color: Theme.of(context).primaryColor),
//        fillColor: Color(0xfff3f3f4),
                      //    filled: true,
                      labelText: DemoLocalization.of(context)
                          .getTranslatedValue("phone_number"),
                      hintText: 'Enter your phoneNumber',
                      labelStyle: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.purple,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'phone number is required';
                      }

                      return null;
                    },
                    onChanged: (val) => setState(() => phoneNumber = val),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                    1.7,
                    ButtonTheme(
                      minWidth: 200,
                      height: 50,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          color: Colors.purple,
                          child: Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue("update"),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await Database(uid: user.uid).updateUserData(
                                displayName ?? snapshot.data.displayName,
                                emailAdd ?? snapshot.data.email,
                                phoneNumber ?? snapshot.data.phoneNumber,
                              );
                              Navigator.pop(context);
                            }
                          }),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
