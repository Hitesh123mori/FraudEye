
import 'package:hack_nu_thon_6/apis/init/config.dart';

class BankUserApis{


  static final _collectionRefBank = Config.firestore.collection("bank_users");


  static Future<dynamic> getUserById(String userId) async {
    try {

      final docSnapshot = await _collectionRefBank.doc(userId).get();
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