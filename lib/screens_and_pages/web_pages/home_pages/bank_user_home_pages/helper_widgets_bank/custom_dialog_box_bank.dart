import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/main.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/bank_user_home_pages/helper_widgets_bank/pdf_file_screen_bank.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/manually_form_screen.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/pdf_file_screen.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'csv_file_screen_bank.dart';
import 'manually_form_screen_bank.dart';

class CustomDialogBoxBank extends StatefulWidget {
  const CustomDialogBoxBank({super.key});

  @override
  State<CustomDialogBoxBank> createState() => _CustomDialogBoxBankState();
}

class _CustomDialogBoxBankState extends State<CustomDialogBoxBank> {

  int selectedOption = -1;
  bool showNextScreen = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: mq.width * 0.6,
        height: 600,
        constraints: BoxConstraints(
          maxHeight: mq.height * 0.9,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.theme['backgroundColor'],
          borderRadius: BorderRadius.circular(10),
        ),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    showNextScreen ? "Complete details" : "Select Options",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  showNextScreen ? _nextScreenContent() : _selectionScreenContent(),
                  SizedBox(height: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close",style: GoogleFonts.poppins(color: AppColors.theme['primaryColor']),),
                  ),
                  if (showNextScreen)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showNextScreen = false;
                          selectedOption = -1;
                        });
                      },
                      child: Text("Prev",style: GoogleFonts.poppins(color: AppColors.theme['primaryColor']),),
                    ),
                  if (!showNextScreen && selectedOption != -1)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showNextScreen = true;
                        });
                      },
                      child: Text("Next",style: GoogleFonts.poppins(color: AppColors.theme['primaryColor']),),
                    ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Selection screen with two options
  Widget _selectionScreenContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.theme['ghostWhiteColor'],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.theme['primaryColor']!, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose an option below to proceed:",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.theme['textColor'],
                ),
              ),
              SizedBox(height: 8),
              Text("1. If you have a small number of transactions, you can manually enter each one using Option 1."),
              SizedBox(height: 4),
              Text("2. If you have a large amount of data, uploading a CSV file (Option 2) is a better choice."),
              SizedBox(height: 4),
              Text("3️. Instead of manually entering and requesting all transactions, you can upload a CSV, and we will provide an output CSV in return."),
              SizedBox(height: 4),
              Text("4️. After selecting an option, scroll down and click 'Next' to continue."),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildOptionContainer(0, "Fill Form Manually", "Manually enter the details of each transaction."),
        SizedBox(height: 10),
        _buildOptionContainer(1, "Upload .CSV File", "Upload a CSV file for efficiently processing a large number of transactions."),
        SizedBox(height: 10),
        _buildOptionContainer(2, "Upload .PDF File", "Upload a PDF file for efficiently processing a organization's financial data."),

        Divider(),
      ],
    );
  }

  /// Next screen (shows only selected content)
  Widget _nextScreenContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        selectedOption==2 ? PdfFileScreenBank() : (selectedOption == 0 ? ManuallyFormScreenBank() : OptionTwoScreenBank()),
      ],
    );
  }


  /// Option container with selection logic
  Widget _buildOptionContainer(int index, String text, String subtext) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = index;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 80,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selectedOption == index
                ? AppColors.theme['primaryColor']
                : AppColors.theme['ghostWhiteColor'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: index == 0
                    ? Colors.green.withOpacity(0.3)
                    : (index == 1
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3)),

                child: Icon(
                  index == 0
                      ? Icons.assignment_rounded
                      : (index == 1
                      ? Icons.table_chart
                      : Icons.picture_as_pdf_outlined),
                  color: index == 0
                      ? Colors.green
                      : (index == 1 ? Colors.blue : Colors.red),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtext,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
