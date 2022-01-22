import 'package:EasyPark/Models/fade_animation.dart';
import 'package:EasyPark/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class ContactUss extends StatelessWidget {
  static const routeName = '/contact-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Easy Park',
        textColor: Colors.white,
        backgroundColor: Colors.purple.shade300,
        email: 'easypark2020@gmail.com',
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: FadeAnimation(
          1.4,
          ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal.shade900,
            // logo: AssetImage('images/crop.jpg'),
            email: 'easypark2020@gmail.com',
            companyName:
                DemoLocalization.of(context).getTranslatedValue("easy_park"),
            companyColor: Colors.purple.shade100,
            phoneNumber: '01127610207',
            website: 'https://google.com',
            tagLine: '',
            taglineColor: Colors.teal.shade100,
          ),
        ),
      ),
    );
  }
}
