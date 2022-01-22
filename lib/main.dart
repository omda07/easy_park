import 'package:EasyPark/Models/app-context.dart';
import 'package:EasyPark/localization/demo_localization.dart';
import 'package:EasyPark/provider/user.dart';
import 'package:EasyPark/widgets/contact_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EasyPark/provider/app_state.dart';
import 'package:EasyPark/provider/park.dart';
import 'package:EasyPark/provider/park_details.dart';
import 'package:EasyPark/screens/garage_details_screen.dart';
import 'package:EasyPark/screens/login_form.dart';

import 'package:EasyPark/screens/main_page.dart';
import 'package:EasyPark/screens/profile_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './screens/about_me.dart';
import 'package:provider/provider.dart';
import './provider/park_details.dart';
import './provider/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyHomePageState state =
        context.findAncestorStateOfType<_MyHomePageState>();
    state.setLocale(locale);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppContext>.value(
          value: AppContext(),
        ),
        ChangeNotifierProvider<AppState>.value(
          value: AppState(),
        ),
        ChangeNotifierProvider<ParkDetails>.value(
          value: ParkDetails(),
        ),
        ChangeNotifierProvider<Park>.value(
          value: Park(),
        ),
        ChangeNotifierProvider<User>.value(
          value: User(),
        ),
      ],
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          locale: _locale,
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          title: 'EasyPark',
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.white,
            fontFamily: 'Lato',
          ),
          //initialRoute:'',
          home: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                if (snapshot.hasData) {
                  return MainPage();
                }
                return LoginForm();
              }
            },
          ),

          routes: {
            AboutMe.routeName: (ctx) => AboutMe(),
            ContactUss.routeName: (ctx) => ContactUss(),
            MainPage.routeName: (ctx) => MainPage(),
            ProfilePage.routeName: (ctx) => ProfilePage(),
            //  BookingScreen.routeName: (ctx) => BookingScreen(),
            //         FavoriteItem.routeName: (ctx) => FavoriteItem(),
//          SearchGarageScreen.routeName: (ctx) => SearchGarageScreen(),
            GarageDetailsScreen.routeName: (ctx) => GarageDetailsScreen(),
            // HomePage.routeName: (ctx) => HomePage(),
          },
        ),
      ),
    );
  }
}
