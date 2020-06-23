import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Name extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<Name> {
  @override
  Widget build(BuildContext context) {

    final Names = Provider.of<QuerySnapshot>(context);
    //print(brews.documents);
    for (var doc in Names.documents) {
      print(doc.data);
    }

    return Container(

    );
  }
}
