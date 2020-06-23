import 'package:cloud_firestore/cloud_firestore.dart';

class crudMethods {



  Future<void> addData(carData) async {

      await Firestore.instance.collection('testcrud').add(carData).catchError((e){
      print(e);
    });
  }

  getData() async{
    return await Firestore.instance.collection('testcrud').getDocuments();
  }
}