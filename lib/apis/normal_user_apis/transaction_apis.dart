
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/model/transacation_model.dart';


class TransactionApis {

  static final _collectionRefNormal = Config.firestore.collection("normal_users");
  static final _collectionRefBank = Config.firestore.collection("bank_users");


  /// Adds a sub-collection inside a specific normal user document.
  static Future<bool> addTransaction(String userId, TransacationModel transactionData) async {
    try {
      var docRef = await _collectionRefNormal
          .doc(userId)
          .collection("transactions")
          .add(transactionData.toJson());

      String docId = docRef.id;
      await docRef.update({"id": docId});

      print("Transaction added successfully with ID: $docId");

      return true;
    } catch (e) {
      print("Error adding transaction: $e");
      return false;
    }
  }

  static Future<List<List<String>>> fetchUserTransactions(String userId) async {
    List<List<String>> transactionsList = [];
    try {
      var snapshot = await _collectionRefNormal
          .doc(userId)
          .collection("transactions")
          .orderBy("timestamp", descending: true)
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        String labelValue = (data["label"] ?? "").toString();

        transactionsList.add([
          data["timestamp"] ?? "",
          data["option"] ?? "",
          data["inputCsvUrl"] ?? "",
          data["outputCsvUrl"] ?? "",
          (labelValue == "0") ? "Authorized" : "Suspicious"
        ]);
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
    return transactionsList;
  }

  static Future<List<List<String>>> fetchAllTransactions() async {
    List<List<String>> transactionsList = [];

    try {
      var usersSnapshot = await _collectionRefNormal.get();

      for (var userDoc in usersSnapshot.docs) {
        var userId = userDoc.id;
        var userEmail = userDoc.data()["email"] ?? "Unknown";

        var transactionsSnapshot = await _collectionRefNormal
            .doc(userId)
            .collection("transactions")
            .orderBy("timestamp", descending: true)
            .get();

        for (var doc in transactionsSnapshot.docs) {
          var data = doc.data();
          String labelValue = (data["label"] ?? "").toString();

          transactionsList.add([
            data["timestamp"] ?? "",
            userEmail,
            data["option"] ?? "",
            data["inputCsvUrl"] ?? "",
            data["outputCsvUrl"] ?? "",
            (labelValue == "0") ? "Authorized" : "Suspicious"
          ]);
        }
      }
    } catch (e) {
      print("Error fetching all transactions: $e");
    }

    return transactionsList;
  }

}


