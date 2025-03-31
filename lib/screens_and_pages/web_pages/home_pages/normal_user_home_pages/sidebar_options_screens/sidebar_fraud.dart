import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/table_normal_user.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_home.dart';
import 'package:provider/provider.dart';

class SidebarFraud extends StatefulWidget {
  const SidebarFraud({super.key});

  @override
  State<SidebarFraud> createState() => _SidebarFraudState();
}

class _SidebarFraudState extends State<SidebarFraud> {
  List<List<String>> hd = [] ;

  @override
  void initState(){
    super.initState();
    final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
    fetchTransactionProvider.fetchHistory(context);
    hd = fetchTransactionProvider.recentHistory;
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
          TableScreen(data: suspiciousTransactions),
        ],
      ),
    );
  }
}
