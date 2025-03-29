
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';

class AdminUserApis{

  static final _collectionRefAdmin = Config.firestore.collection("admins");


  static Future<dynamic> getUserById(String userId) async {
    try {

      final docSnapshot = await _collectionRefAdmin.doc(userId).get();
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