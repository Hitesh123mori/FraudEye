
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/model/transacation_model.dart';


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

  /// Fetches all transactions of a particular user.
  static Future<List<List<String>>> fetchUserTransactions(String userId) async {
    List<List<String>> transactionsList = [];
    try {
      var snapshot = await _collectionRefNormal
          .doc(userId)
          .collection("transactions")
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



}
