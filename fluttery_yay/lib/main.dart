import 'package:flutteryyay/Pages/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteryyay/Pages/WelcomePage.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'Models/User.dart';
import 'Wrapper.dart';
import 'Services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}



