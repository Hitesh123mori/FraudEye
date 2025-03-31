import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/bank_user_home_pages/helper_widgets_bank/table_normal_bank.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/table_normal_user.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_home.dart';
import 'package:provider/provider.dart';

class SidebarFraudBank extends StatefulWidget {
  const SidebarFraudBank({super.key});

  @override
  State<SidebarFraudBank> createState() => _SidebarFraudBankState();
}

class _SidebarFraudBankState extends State<SidebarFraudBank> {
  List<List<String>> hd = [] ;

  @override
  void initState(){
    super.initState();
    final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
    fetchTransactionProvider.fetchHistory(context);
    hd = fetchTransactionProvider.allTransactions;
  }

  @override
  Widget build(BuildContext context) {

    List<List<String>> suspiciousTransactions =
    hd.where((row) => row.last.toLowerCase() == "suspicious").toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Fraudulent Transactions",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          TableNormalBank(data: suspiciousTransactions),
        ],
      ),
    );
  }
}
