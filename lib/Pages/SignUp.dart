import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteryyay/Services/crud.dart';
import 'package:flutteryyay/home.dart';
import 'package:flutteryyay/Pages/SignUpGoogle.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {


  String _emailID;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  String name;
  crudMethods crudObj = new crudMethods();


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
                        "Sign",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 190, 0, 0),
                      child: Text(
                        "Up",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(145, 180, 0, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35, left: 35, right: 35),
                  child: Column(
                      children: <Widget>[
//                        TextField(
//                            style: TextStyle(
//                              color: Colors.white,
//                            ),
//                            decoration: InputDecoration(
//                              hintText: "Name",
//                              hintStyle: TextStyle(
//                                fontFamily: "Monster",
//                                fontWeight: FontWeight.bold,
//                                color: Colors.grey,
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.teal),),
//                            )
//                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        Form(
                          key: _formKey,
                          child: Column(

                            children: <Widget>[
                              TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                  },
                                  onSaved: (input) => name = input,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                      fontFamily: "Monster",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),),
                                  )
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Please type a valid email';
                                    }
                                  },
                                  onSaved: (input) => _emailID = input,
                                  decoration: InputDecoration(
                                    hintText: "Email ID",
                                    hintStyle: TextStyle(
                                      fontFamily: "Monster",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),),
                                  )
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (input) {
                                  if (input.length < 6){
                                    return 'Please type a longer password';
                                  }
                                },
                                onSaved: (input) => _password = input,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontFamily: "Monster",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),),
                                ),
                                obscureText: true,
                              ),
                            ],

                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          height: 40,
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.tealAccent,
                            color: Colors.teal,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                signUp(context);
                              },
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Monster",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                        Container(
                          height: 40,
                          child: FlatButton(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)),
                            color: Colors.teal,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/');
                            },
                            child: Center(
                              child: Text(
                                "Go back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Monster",
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                  )
              )
            ]
        )
    );


  }

  Future<void> signUp(context) async {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailID, password: _password);
        setState(() => loading = true);
        print("Successfully Registered!");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        setState(() {
          loading = false;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('SignUp Failed')),
                  titleTextStyle: TextStyle(
                    color: Colors.teal,
                    fontFamily: 'Monster',
                    fontSize: 20.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  content: Text(
                      'Check your Email ID and make sure password is over 6 letters'),
                  contentTextStyle: TextStyle(
                    fontFamily: 'Monster',
                    color: Colors.black,
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text('Try Again'),
                    )
                  ],
                );
              }
          );
        }
        );
      };
    }


    Map<String, dynamic> carData = {'Name': this.name, 'Email' : this._emailID, 'Password' : this._password};
    await crudObj.addData(carData).then((result) {
    }).catchError((e){
        print(e);
        print(e);
    });



  }


  }
