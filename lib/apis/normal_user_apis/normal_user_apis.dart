
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';

class NormalUserApis{

  static final _collectionRefNormal = Config.firestore.collection("normal_users");


  static Future<dynamic> getUserById(String userId) async {
    try {

      final docSnapshot = await _collectionRefNormal.doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (error, stackTrace) {
      return {
        "error": error.toString(),
        "stackTrace": stackTrace.toString(),
      };
    }
  }


}