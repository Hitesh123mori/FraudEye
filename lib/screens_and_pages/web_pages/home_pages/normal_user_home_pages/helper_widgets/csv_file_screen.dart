import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart'; // Import CSV package
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:icons_plus/icons_plus.dart';

class OptionTwoScreen extends StatefulWidget {
  @override
  _OptionTwoScreenState createState() => _OptionTwoScreenState();
}

class _OptionTwoScreenState extends State<OptionTwoScreen> {

  List<String> categories = [
    'Health Care',
    'Credit Card',
    'Financial statement fraud detection',
    'Loan fraud detection'
  ];

  List<Icon> cicons = [
    Icon(Icons.health_and_safety_outlined),
    Icon(Icons.credit_card),
    Icon(Icons.report_outlined),
    Icon(Icons.money),
  ] ;
  
  final bool isLoading = false;
  String? fileName;
  Uint8List? fileBytes;
  List<List<dynamic>>? csvData;
  bool isUploading = false;
  String? selectedCategory;

  Future<void> _pickCSVFile() async {
    setState(() {
      isUploading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      if (kIsWeb) {
        fileBytes = result.files.single.bytes;
        fileName = result.files.single.name;

        UploadTask task = Config.storage.ref().child("hacknuthon6/files/$fileName").putData(fileBytes!) ;

        TaskSnapshot snapshot = await task;

        final downloadUrl = await snapshot.ref.getDownloadURL();

        print("download url : $downloadUrl") ;

        _parseCSV(fileBytes!);

      } else {
        File file = File(result.files.single.path!);
        fileName = file.path.split('/').last;
        _parseCSV(file.readAsBytesSync());
      }
    }

    setState(() {
      isUploading = false;
    });
  }

  void _parseCSV(Uint8List bytes) {
    String csvString = String.fromCharCodes(bytes);
    List<List<dynamic>> data = const CsvToListConverter().convert(csvString);

    setState(() {
      csvData = data;
    });
  }

  /// extract data of csv
  void _printCSVData() {
    if (csvData == null) {
      print("No CSV data available.");
      return;
    }

    List<String> headers = csvData![0].map((e) => e.toString()).toList();

    for (int i = 1; i < csvData!.length; i++) {
      Map<String, dynamic> rowMap = {};
      for (int j = 0; j < headers.length; j++) {
        rowMap[headers[j]] = csvData![i][j];
      }
      print("Row $i: $rowMap");
    }
  }

  void _generate() {
    if (selectedCategory != null) {
      print("Selected Category: $selectedCategory");
    } else {
      print("No category selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload CSV File",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.theme['ghostWhiteColor'],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor:
                AppColors.theme['primaryColor']!.withOpacity(0.3),
                child: Icon(
                  Icons.cloud_upload,
                  color: AppColors.theme['primaryColor'],
                  size: 25,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: isUploading
                    ? LinearProgressIndicator(
                  backgroundColor:
                  AppColors.theme['primaryColor']!.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.theme['primaryColor']!,
                  ),
                )
                    : Text(
                  fileName ?? "Choose CSV file",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _pickCSVFile,
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.theme['primaryColor'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        fileName == null ? "Choose CSV" : "Change File",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Select Category",
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(categories.length, (i) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = categories[i];
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.theme['op${i + 1}']?.withOpacity(0.5) ?? Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedCategory == categories[i]
                          ? (AppColors.theme['op${i + 1}'] ?? Colors.blue)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      cicons[i],
                      SizedBox(width: 5),
                      Text(categories[i]),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButton(
              textSize: 16,
              height: 35,
              width: 150,
              textColor: Colors.white,
              bgColor: AppColors.theme['primaryColor'],
              onTap: () {
                _generate();
                _printCSVData();
              },
              title: "Generate Report",
              isLoading: isLoading,
              loadWidth: 40,
            ),
          ],
        ),
      ],
    );
  }
}