import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteryyay/Pages/WelcomePage.dart';

String _emailID;
String _password;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class PasswordReset extends StatelessWidget {

  String email=" ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(35, 110, 0, 0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(35, 190, 0, 0),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(235, 180, 0, 0),
                          child: Text(
                            ".",
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),

                          Container(
                            padding: EdgeInsets.only(
                                top: 325, left: 35, right:35),
                            child: Column(

                                children: <Widget>[
                                  Form(
                                    key: _formKey,
                                    child: Column(

                                      children: <Widget>[
                                        TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return 'Please type a valid email';
                                              }else{
                                                email=input;
                                              }
                                              return null;
                                            },
                                            onSaved: (input) =>
                                            _emailID = input,
                                            decoration: InputDecoration(
                                              hintText: "Email ID",
                                              hintStyle: TextStyle(
                                                fontFamily: "Monster",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.teal),
                                              ),
                                            ),
                                          style:TextStyle(
                                            color: Colors.white

                                          )
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),

                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.teal)),
                                          color: Colors.teal,
                                          onPressed: () async{
                                            try {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                FirebaseAuth.instance
                                                    .sendPasswordResetEmail(
                                                    email: email);
                                               showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      // return object of type Dialog
                                                      return AlertDialog(
                                                        content: Text('Email sent'),
                                                        actions: <Widget> [
                                                          FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pushNamed('/passwordreset');
                                                            },
                                                            child: Text('Okay'),
                                                          )
                                                        ],
                                                      );
                                                    }
                                                );
                                              }
                                            } catch (e) {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    // return object of type Dialog
                                                    return AlertDialog(
                                                      title: Center(child: Text('Alert')),
                                                    titleTextStyle: TextStyle(
                                                    color: Colors.teal,
                                                    fontFamily: 'Monster',
                                                    fontSize: 20.0,
                                                    letterSpacing: 1.5,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.underline,
                                                    ),
                                                      content: Text('Email not sent'),
                                                      contentTextStyle: TextStyle(
                                                        fontFamily: 'Monster',
                                                        color: Colors.black,
                                                      ),

                                                      actions: <Widget> [
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pushNamed('/passwordreset');
                                                          },
                                                          child: Text('Try Again'),
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                            }

                                          },
                                          child: Center(
                                            child: Text(
                                              "Send Email",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Monster",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.black)),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.of(context).pushNamed('/');
                                          },
                                          child: Center(
                                            child: Text(
                                              "Go back",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Monster",
                                              ),
                                            ),
                                          ),
                                        )
                                      ]
                                    ),
                                  ),
                                      ],

                                    ),
                                  )

                                ]
                            )
                        )
                      ]
                  )
              );

  }
}