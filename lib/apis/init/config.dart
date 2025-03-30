import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Config{


  static final FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app('hacknuthon_1'));

  static final FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: Firebase.app('hacknuthon_1'));

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instanceFor(app: Firebase.app('hacknuthon_2'));

  static User get user {
    if (auth.currentUser == null) {
      throw Exception("User is not authenticated.");
    }
    return auth.currentUser!;
  }

}