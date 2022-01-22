import 'package:EasyPark/Models/app-context.dart';
import 'package:EasyPark/Models/auth-result-status.dart';
import 'package:EasyPark/Models/fade_animation.dart';
import 'package:EasyPark/localization/demo_localization.dart';
import 'package:EasyPark/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  // text field state
  String email = '';
  String password = '';
  String displayName = '';
  String phoneNumber = '';

//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

//
//  User _user = User();

  @override
  void initState() {
//    var appContext = Provider.of<AppContext>(context, listen: false);
//    AuthNotifier authNotifier =
//        Provider.of<AuthNotifier>(context, listen: false);
//    initializeCurrentUser(authNotifier);
    super.initState();
  }

  AuthResultStatus _status;

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

//    AuthNotifier authNotifier =
//        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        dynamic result =
            await _auth.signInWithEmailAndPassword(email, password);

        if (result == null) {
          setState(() {
            loading = false;
            error = 'Could not sign in with those credentials';
          });
//          Fluttertoast.showToast(
//              msg: error,
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.BOTTOM,
//              timeInSecForIosWeb: 1,
//              backgroundColor: Colors.red,
//              textColor: Colors.white,
//              fontSize: 16.0);
          print('Exception @createAccount: $error');
        }
      }
//      login(_user, authNotifier);
      //signInWithEmailAndPassword(_user.email, _user.password);
    } else {
      var appContext = Provider.of<AppContext>(context);
      try {
        await appContext.signUp(displayName, email, password);

        Navigator.of(context).pop();
      } catch (e) {
//        Fluttertoast.showToast(
//            msg: e.toString(),
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 16.0);
        print('Exception @createAccount: $error');
      }
    }
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: DemoLocalization.of(context).getTranslatedValue("easy"),
              style: TextStyle(color: Colors.purple, fontSize: 60),
            ),
            TextSpan(text: ' '),
            TextSpan(
              text: DemoLocalization.of(context).getTranslatedValue("park"),
              style: TextStyle(color: Colors.purple, fontSize: 50),
            ),
          ]),
    );
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.account_circle,
            size: 30, color: Theme.of(context).primaryColor),
//        fillColor: Color(0xfff3f3f4),
        filled: true,
        labelText:
            DemoLocalization.of(context).getTranslatedValue("display_name"),
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
      keyboardType: TextInputType.text,
      cursorColor: Colors.purple,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Display Name is required';
        }

        if (value.length < 4 || value.length > 12) {
          return 'Display Name must be betweem 4 and 12 characters';
        }

        return null;
      },
      onChanged: (value) {
        setState(() {
          displayName = value;
        });
      },
//      onSaved: (String value) {
//        _user.displayName = value;
//      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        icon:
            Icon(Icons.email, size: 30, color: Theme.of(context).primaryColor),
//        fillColor: Color(0xfff3f3f4),
        //    filled: true,
        labelText: DemoLocalization.of(context).getTranslatedValue("email"),
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
      //initialValue: 'ahmed@Epark.com',

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
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
//      onSaved: (String value) {
//        _user.email = value;
//      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _obscureTextPass,
      decoration: InputDecoration(
        icon: Icon(Icons.lock, size: 30, color: Theme.of(context).primaryColor),
        suffixIcon: IconButton(
          icon: _obscureTextPass
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {},
        ),
        fillColor: Color(0xfff3f3f4),
        filled: true,
        labelText: DemoLocalization.of(context).getTranslatedValue("password"),
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
      cursorColor: Colors.purple,

      controller: _passwordController,
      validator: (value) {
        if (value == null) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
//      onSaved: (String value) {
//        _user.password = value;
//      },
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: _obscureTextConfirm,
      decoration: InputDecoration(
        icon: Icon(Icons.lock, size: 30, color: Theme.of(context).primaryColor),
        suffixIcon: IconButton(
          icon: _obscureTextPass
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {},
        ),
        fillColor: Color(0xfff3f3f4),
        filled: true,
        labelText:
            DemoLocalization.of(context).getTranslatedValue("confirm_password"),
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
      cursorColor: Colors.purple,
      validator: (value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Theme.of(context).primaryColor,
          Colors.purple[900],
          Colors.purple[500]
        ])),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue("my_account"),
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue("create_account"),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _title(),
                          SizedBox(height: 32),
                          _authMode == AuthMode.Signup
                              ? _buildDisplayNameField()
                              : Container(),
                          SizedBox(height: 24),
                          _buildEmailField(),
                          SizedBox(height: 24),
                          _buildPasswordField(),
                          SizedBox(height: 24),
                          _authMode == AuthMode.Signup
                              ? _buildConfirmPasswordField()
                              : Container(),
                          SizedBox(height: 32),
                          FadeAnimation(
                            1.7,
                            ButtonTheme(
                              minWidth: 200,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                color: Colors.purple,
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  DemoLocalization.of(context)
                                          .getTranslatedValue("switch_to") +
                                      ' ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _authMode = _authMode == AuthMode.Login
                                        ? AuthMode.Signup
                                        : AuthMode.Login;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
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
                                padding: EdgeInsets.all(10.0),
                                onPressed: () => _submitForm(),
                                child: Text(
                                  _authMode == AuthMode.Login
                                      ? 'Login'
                                      : 'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
