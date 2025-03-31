import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/apis/normal_user_apis/transaction_apis.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:provider/provider.dart';

class FetchTransactionProvider extends ChangeNotifier {
  List<List<String>> recentHistory = [];

  Future<void> fetchHistory(BuildContext context) async {
    String? userId = Provider.of<UserProvider>(context, listen: false).user?.userID;
    if (userId == null) return;

    recentHistory = await TransactionApis.fetchUserTransactions(userId);
    notifyListeners();
  }

}
