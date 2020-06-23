import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutteryyay/Services/SignOut.dart';
import 'package:flutteryyay/Pages/WelcomePage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Services/crud.dart';
import 'video_Pages/call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {



  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); //
    }
  }

  final _channelController = TextEditingController();
  crudMethods crudObj1 = new crudMethods();
  String _channelName;
  QuerySnapshot channel;


  /// if channel textField is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        onSaved: (input) => _channelName = input,
                        controller: _channelController,
                        decoration: InputDecoration(
                          errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter name of the channel you want to join',
                          hintStyle: TextStyle(color: Colors.white60)
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 45,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal)),
                          color: Colors.teal,
                          onPressed: () {
                            sendData();
                            onJoin();

                          },
                          child: Text(
                              'Join',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Monster",
                          ),),

                          textColor: Colors.white,
                        ),
                      ),

                    ),
                  ],
                ),
              ),

              Material(
                borderRadius: BorderRadius.circular(1000),
                shadowColor: Colors.tealAccent,
                color: Colors.teal,
                elevation: 7.0,
                child: FlatButton(
                    onPressed: () {
                      _signOut();
                    },
                    child: Center(
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Monster",
                          fontSize: 20.0,

                        ),
                      ),
                    )
                ),
              ),
              Container(
                child: _carList(),
              ),


            ],

          ),


        ),


      ),


    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CallPage(
                channelName: _channelController.text,
              ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    Navigator.pushNamed(context, "/");
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],

    );
  }


  Widget _carList() {
//    @override
//    void initState() {
//      crudObj1.getData().then((results) {
//        setState(() {
//          channel = results;
//        });
//      });
//    }
    if (channel != null) {
      print("Building View CBSDJKVBHSDUJKVBGDJ");
      return ListView.builder(

        itemCount: channel.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i) {
          return Container(
            color: Colors.black,
            child: ListTile(

              title: Text(channel.documents[i].data['channelName']),
            ),
          );
        },
      );
    }
    else{

    }
  }


  void sendData() {
    print(_channelController.text);
    print("reached inside sendData function");
    Map <String, dynamic> crudData1 = {
      'channelName': this._channelController.text,
    };
     crudObj1.addData(crudData1).then((result) {}).catchError((e) {

      print("ERRORORORRORO WOWZAASKFBDUJKCBNSDJKVSBDJKB" + e);

    });

    // update input validation

  }

}