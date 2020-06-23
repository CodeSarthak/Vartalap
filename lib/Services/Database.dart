import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference nameCollection = Firestore.instance.collection('Names');

  Future<void> updateUserData (String name,String email) async {
    return await nameCollection.document(uid).setData({

      'Name': name,
      'Email': email,

    });
  }
  Stream<QuerySnapshot> get Names{
    return nameCollection.snapshots();
  }

}