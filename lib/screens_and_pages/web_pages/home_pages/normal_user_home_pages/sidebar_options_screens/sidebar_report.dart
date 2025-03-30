import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/report_card.dart';

class SidebarReport extends StatefulWidget {
  const SidebarReport({super.key});

  @override
  State<SidebarReport> createState() => _SidebarReportState();
}

class _SidebarReportState extends State<SidebarReport> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Reports and Data",style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
          ),

          ReportCard(
            text: 'All Data',
            subtext: 'Download all transaction data',
            color: AppColors.theme['op1'],
            icon: Icons.dataset,
          ),
          ReportCard(
            text: 'Fraudulent Transactions',
            subtext: 'Download all fraudulent transactions',
            color: AppColors.theme['op2'],
            icon: Icons.dataset,
          ),
          ReportCard(
            text: 'Safe Transactions',
            subtext: 'Download all safe transactions',
            color: AppColors.theme['op3'],
            icon: Icons.dataset,
          ),
          ReportCard(
            text: 'Credit Card Transactions',
            subtext: 'Download all credit card transactions',
            color: AppColors.theme['op4'],
            icon: Icons.dataset,
          ),
          ReportCard(
            text: 'Healthcare Transactions',
            subtext: 'Download all healthcare transactions',
            color: AppColors.theme['op1'],
            icon: Icons.dataset,
          ),


        ],
      ),
    );
  }

}
