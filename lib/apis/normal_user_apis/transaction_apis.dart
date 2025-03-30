import 'dart:developer';
import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/model/transacation_model.dart';
import 'package:path/path.dart';
import 'dart:html' as html;

class TransactionApis {

  static final _collectionRefNormal = Config.firestore.collection("normal_users");

  /// Adds a sub-collection inside a specific normal user document.
  static Future<bool> addTransaction(String userId, TransacationModel transactionData) async {
    try {
      await _collectionRefNormal
          .doc(userId)
          .collection("transactions")
          .add(transactionData.toJson());

      print("Transaction added successfully!");
      return true;
    } catch (e) {
      print("Error adding transaction: $e");
      return false;
    }
  }


}
