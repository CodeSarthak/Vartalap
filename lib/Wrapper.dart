import 'package:flutter/material.dart';
import 'package:flutteryyay/home.dart';
import 'package:flutteryyay/Pages/WelcomePage.dart';
import 'package:flutteryyay/Pages/SignUp.dart';
import 'package:flutteryyay/Models/User.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return LoginPage();
    } else {
      return Home();
    }

  }
}