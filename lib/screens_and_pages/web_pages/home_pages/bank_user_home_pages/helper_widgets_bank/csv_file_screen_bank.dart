import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart'; // Import CSV package
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/apis/normal_user_apis/transaction_apis.dart';
import 'package:hack_nu_thon_6/model/transacation_model.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:hack_nu_thon_6/utils/helper_functions/web_toast.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';



class CsvFileScreenBank extends StatefulWidget {
  @override
  _CsvFileScreenBankState createState() => _CsvFileScreenBankState();
}

class _CsvFileScreenBankState extends State<CsvFileScreenBank> {

  bool isLoading = false;

  List<String> categories = [
    'Health Care',
    'Transaction',
    'Financial statement fraud detection',
    'Loan fraud detection'
  ];

  List<Icon> cicons = [
    Icon(Icons.health_and_safety_outlined),
    Icon(Icons.credit_card),
    Icon(Icons.report_outlined),
    Icon(Icons.money),
  ] ;

  String? fileName;
  Uint8List? fileBytes;
  bool isUploading = false;
  String? selectedCategory;
  List<List<dynamic>> csvData = [];


  void _parseCSV(Uint8List bytes) {

    String csvString = String.fromCharCodes(bytes);
    List<List<dynamic>> data = const CsvToListConverter().convert(csvString);

    setState(() {
      csvData = data;
    });

  }


  // add to csv
  void addToCSV(List<dynamic> row,List<List<dynamic>> dataCSV) {
    setState(() {
      dataCSV.add(row);
    });
  }


  /// for normal transaction
  Future<String> RequestNormalTransaction(List<dynamic> row) async {

    List<String> columnNames = [
      "timestamp",
      "customer_id",
      "merchant_id",
      "transaction_amount",
      "merchant_category_code",
      "merchant_name",
      "transaction_type",
      "country_code",
      "zip_code",
      "distance_from_home",
      "time_since_prev_tx",
      "daily_tx_count",
      "daily_tx_amount",
      "amount_to_daily_ratio",
      "card_present",
      "suspicious_merchant_flag"
    ];

    print("Starting request with row: $row");
    String res = "0";

    isLoading = true;

    const String apiUrl = "http://10.21.9.224:5000/predict";

    if (columnNames.length != row.length) {
      print("Error: Column names and row values count mismatch.");
      isLoading = false;
      return res;
    }

    Map<String, dynamic> requestBody = {};

    for (int i = 0; i < columnNames.length; i++) {
      var value = row[i];

      if (value is List) {
        requestBody[columnNames[i]] = jsonEncode(value);
      } else {
        requestBody[columnNames[i]] = value.toString();
      }
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        res = jsonResponse['prediction'].toString();
      } else {
        print("Error: Failed to get response. Status: ${response.statusCode}");
      }

      return res;
    } catch (e) {
      print("Error during request: $e");
      isLoading = false;
      return "0";
    }
  }

  /// for health care transaction
  Future<String> requestHealthCareTransaction(List<dynamic> row) async {

    String requestBody = jsonEncode(row);

    const String apiUrl = "http://10.21.25.124:5000/predict";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String res = jsonResponse['prediction'].toString();
        return res;
      } else {
        return "0";
      }
    } catch (e) {
      print("Error during request: $e");
      return "0";
    }
  }


  Future<void> handleButton(BuildContext context) async {

    if (fileBytes == null || fileBytes!.isEmpty) {
      print("Error: File is empty or null.");
      return;
    }

    _parseCSV(fileBytes!);

    // Upload input CSV
    UploadTask task1 = Config.storage.ref().child("hacknuthon6/files/input_data_${DateTime.now()}.csv").putData(fileBytes!);
    TaskSnapshot snapshot1 = await task1;
    final inputUrl = await snapshot1.ref.getDownloadURL();
    print("Input CSV URL: $inputUrl");

    if (selectedCategory == "Transaction") {

      List<dynamic> columnNames2 = [
        "timestamp",
        "customer_id",
        "merchant_id",
        "transaction_amount",
        "merchant_category_code",
        "merchant_name",
        "transaction_type",
        "country_code",
        "zip_code",
        "distance_from_home",
        "time_since_prev_tx",
        "daily_tx_count",
        "daily_tx_amount",
        "amount_to_daily_ratio",
        "card_present",
        "suspicious_merchant_flag",
        'is_fraud'
      ];

      final List<List<dynamic>> csvData2 = [columnNames2];

      for (int i = 1; i < csvData.length; i++) {
        final res1 = await RequestNormalTransaction(csvData[i]);
        csvData[i].add(res1);
        addToCSV(csvData[i], csvData2);

        TransacationModel tmodel = TransacationModel(
          timestamp: DateTime.now().toString(),
          option: selectedCategory ?? "",
          inputCsvUrl: inputUrl,
          outputCsvUrl: "", // Will be updated later
          label: res1,
          id: '',
        );

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final fetchProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
        await fetchProvider.fetchHistory(context) ;

        await TransactionApis.addTransaction(userProvider.user?.userID ?? "", tmodel);


      }

      String csvString2 = const ListToCsvConverter().convert(csvData2);
      final bytes2 = utf8.encode(csvString2);

      final blob2 = html.Blob([bytes2]);
      final url2 = html.Url.createObjectUrlFromBlob(blob2);
      final anchor2 = html.AnchorElement(href: url2)
        ..setAttribute("download", "output_data_${DateTime.now()}.csv")
        ..click();
      html.Url.revokeObjectUrl(url2);

      UploadTask task2 = Config.storage.ref().child("output_data_${DateTime.now()}.csv").putData(bytes2);
      TaskSnapshot snapshot2 = await task2;
      final outputUrl = await snapshot2.ref.getDownloadURL();

      print("Output CSV URL: $outputUrl");

    } else {

      List<dynamic> columnNames3 = [
        "PerProviderAvg_InscClaimAmtReimbursed",
        "PerProviderAvg_DeductibleAmtPaid",
        "PerProviderAvg_IPAnnualReimbursementAmt",
        "PerProviderAvg_IPAnnualDeductibleAmt",
        "PerProviderAvg_OPAnnualReimbursementAmt",
        "PerProviderAvg_OPAnnualDeductibleAmt",
        "PerProviderAvg_Age",
        "PerProviderAvg_NoOfMonths_PartACov",
        "PerProviderAvg_NoOfMonths_PartBCov",
        "PerProviderAvg_DurationofClaim",
        "PerProviderAvg_NumberofDaysAdmitted",
        "PerAttendingPhysician Avg_InscClaimAmtReimbursed",
        "PerAttendingPhysician Avg_DeductibleAmtPaid",
        "PerAttendingPhysician Avg_IPAnnualReimbursementAmt",
        "PerAttendingPhysician Avg_IPAnnualDeductibleAmt",
        "PerAttendingPhysician Avg_OPAnnualReimbursementAmt",
        "PerAttendingPhysician Avg_OPAnnualDeductibleAmt",
        "PerAttendingPhysician Avg_DurationofClaim"
      ];

      final List<List<dynamic>> csvData3 = [columnNames3];


      for (int i = 0; i < csvData.length; i++) {
        print(csvData[i]);
        final res2 = await requestHealthCareTransaction(csvData[i]);
        print(res2);
        csvData[i].add(res2);
        addToCSV(csvData[i], csvData);

        TransacationModel tmodel = TransacationModel(
          timestamp: DateTime.now().toString(),
          option: selectedCategory ?? "",
          inputCsvUrl: inputUrl,
          outputCsvUrl: "",
          label: res2,
          id: '',
        );

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final fetchProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
        await fetchProvider.fetchHistory(context) ;

        await TransactionApis.addTransaction(userProvider.user?.userID ?? "", tmodel);
      }

    }
  }

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

      } else {
        File file = File(result.files.single.path!);
        fileName = file.path.split('/').last;
      }
    }

    setState(() {
      isUploading = false;
    });
  }

  //
  // void _generate() {
  //   if (selectedCategory != null) {
  //     print("Selected Category: $selectedCategory");
  //   } else {
  //     print("No category selected.");
  //   }
  // }

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
                // _generate();
                handleButton(context);
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
