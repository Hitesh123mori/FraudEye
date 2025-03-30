import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart'; // Import CSV package
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';

class OptionTwoScreenBank extends StatefulWidget {
  @override
  _OptionTwoScreenState createState() => _OptionTwoScreenState();
}

class _OptionTwoScreenState extends State<OptionTwoScreenBank> {
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
        Row(
          children: [
            for (var category in [
              'Option 1',
              'Option 2',
              'Option 3',
              'Option 4'
            ])
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.theme['op${category.split(' ')[1]}']
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedCategory == category
                            ? AppColors.theme['op${category.split(' ')[1]}']
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.medical_information_outlined),
                        SizedBox(width: 5),
                        Text(category),
                      ],
                    ),
                  ),
                ),
              ),
          ],
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
