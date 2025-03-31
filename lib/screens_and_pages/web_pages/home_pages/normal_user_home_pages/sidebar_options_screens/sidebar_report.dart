import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_home.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/report_card.dart';
import 'package:provider/provider.dart';

class SidebarReport extends StatefulWidget {
  const SidebarReport({super.key});

  @override
  State<SidebarReport> createState() => _SidebarReportState();
}

class _SidebarReportState extends State<SidebarReport> {

  List<List<String>> hd = [] ;

  @override
  void initState(){
    super.initState();
    final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
    hd = fetchTransactionProvider.recentHistory;
  }

  List<String> columnNames = ["TimeStamp", "Option", "Input CSV", "OutputCSV", "Label"];


  /// csv download for
  void AllDataCSV() {

    final List<List<String>> csvData = [columnNames, ...hd];
    String csvString = const ListToCsvConverter().convert(csvData);
    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "all_data.csv")
      ..click();
    html.Url.revokeObjectUrl(url);

  }


  /// fraud transactions
  void FraudTransactionDataCSV() {

    final List<List<String>> filteredHd =
    hd.where((row) => row.last.toLowerCase() == "suspicious").toList();

    final List<List<String>> csvData = [columnNames, ...filteredHd];

    String csvString = const ListToCsvConverter().convert(csvData);
    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "fraud_transactions.csv")
      ..click();
    html.Url.revokeObjectUrl(url);

  }

  /// safe transactions
  void SafeTransactionDataCSV() {

    final List<List<String>> filteredHd =
    hd.where((row) => row.last.toLowerCase() == "authorized").toList();

    final List<List<String>> csvData = [columnNames, ...filteredHd];

    String csvString = const ListToCsvConverter().convert(csvData);
    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "safe_transactions.csv")
      ..click();
    html.Url.revokeObjectUrl(url);

  }

  ///credit card transacations
  void CreditCardTransactionDataCSV() {
    final List<List<String>> filteredHd =
    hd.where((row) => row[1] == "Transaction").toList();

    final List<List<String>> csvData = [columnNames, ...filteredHd];

    String csvString = const ListToCsvConverter().convert(csvData);
    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "transactions.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  ///health care transactions
  void HealthCareTransactionDataCSV() {
    final List<List<String>> filteredHd =
    hd.where((row) => row[1] == "Health Care").toList();

    final List<List<String>> csvData = [columnNames, ...filteredHd];

    String csvString = const ListToCsvConverter().convert(csvData);
    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "health_care_transactions.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }








  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Reports and Data",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          ReportCard(
            text: 'All Data',
            subtext: 'Download all transaction data',
            color: AppColors.theme['op1'],
            icon: Icons.dataset,
            onTapCSV: () {
              AllDataCSV();
            },
            // onTapPDF: () {},
          ),
          ReportCard(
            text: 'Fraudulent Transactions',
            subtext: 'Download all fraudulent transactions',
            color: AppColors.theme['op2'],
            icon: Icons.dataset,
            onTapCSV: () {
              FraudTransactionDataCSV();
            },
            // onTapPDF: () {},
          ),
          ReportCard(
            text: 'Safe Transactions',
            subtext: 'Download all safe transactions',
            color: AppColors.theme['op3'],
            icon: Icons.dataset,
            onTapCSV: () {
              SafeTransactionDataCSV();
            },
            // onTapPDF: () {},
          ),
          ReportCard(
            text: 'Transactions',
            subtext: 'Download all credit card transactions',
            color: AppColors.theme['op4'],
            icon: Icons.dataset,
            onTapCSV: () {
              CreditCardTransactionDataCSV();
            },
            // onTapPDF: () {},
          ),
          ReportCard(
            text: 'Healthcare Transactions',
            subtext: 'Download all healthcare transactions',
            color: AppColors.theme['op1'],
            icon: Icons.dataset,
            onTapCSV: () {
              HealthCareTransactionDataCSV();
            },
            // onTapPDF: () {},
          ),
        ],
      ),
    );
  }
}
