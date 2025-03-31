import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/apis/normal_user_apis/transaction_apis.dart';
import 'package:hack_nu_thon_6/model/transacation_model.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:hack_nu_thon_6/utils/helper_functions/web_toast.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:hack_nu_thon_6/utils/widgets/text_feild/custom_text_feild.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:html' as html;


class ManuallyFormScreenBank extends StatefulWidget {
  const ManuallyFormScreenBank({super.key});

  @override
  State<ManuallyFormScreenBank> createState() => _ManuallyFormScreenBankState();
}

class _ManuallyFormScreenBankState extends State<ManuallyFormScreenBank> {

  bool isLoading = false;

  final TextEditingController timestampController = TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController transactionAmountController =
  TextEditingController();
  final TextEditingController merchantCategoryCodeController =
  TextEditingController();
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController distanceFromHomeController =
  TextEditingController();
  final TextEditingController timeSincePrevTxController =
  TextEditingController();
  final TextEditingController dailyTxCountController = TextEditingController();
  final TextEditingController dailyTxAMTCountController =
  TextEditingController();
  final TextEditingController amountToDailyRatioController =
  TextEditingController();

  String selectedTransactionType = 'Purchase';
  bool cardPresent = false;
  bool suspiciousMerchant = false;

  Future<String> handleSubmit() async {

    String res = "0";
    setState(() {
      isLoading = true;
    });

    const String apiUrl = "http://10.21.9.224:5000/predict";

    Map<String, dynamic> requestBody = {
      "customer_id": customerIdController.text.trim(),
      "merchant_id": merchantNameController.text.trim(),
      "transaction_amount":
      double.tryParse(transactionAmountController.text) ?? 0.0,
      "merchant_category_code":
      int.tryParse(merchantCategoryCodeController.text) ?? 0,
      "merchant_name": merchantNameController.text.trim(),
      "transaction_type": selectedTransactionType,
      "country_code": countryCodeController.text.trim(),
      "zip_code": zipCodeController.text.trim(),
      "distance_from_home":
      double.tryParse(distanceFromHomeController.text) ?? 0.0,
      "time_since_prev_tx":
      double.tryParse(timeSincePrevTxController.text) ?? 0.0,
      "daily_tx_count": int.tryParse(dailyTxCountController.text) ?? 0,
      "daily_tx_amount": double.tryParse(dailyTxAMTCountController.text) ?? 0.0,
      "amount_to_daily_ratio":
      double.tryParse(amountToDailyRatioController.text) ?? 0.0,
      "card_present": cardPresent ? 1 : 0,
      "suspicious_merchant_flag": suspiciousMerchant ? 1 : 0
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        res  = jsonResponse['prediction'] ;
        WebToasts.showToastification(
            "Success",
            "Prediction: ${jsonResponse['prediction']}",
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            context);
      } else {
        WebToasts.showToastification(
            "Error",
            "Failed to get response.",
            Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
            ),
            context);
      }
      return res;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context,userProvider,child){
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This is for Transaction fraud detection only.",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFeild(
                hintText: 'Timestamp (MM:SS.t)',
                controller: timestampController,
                isNumber: false,
                prefixicon: Icon(Icons.access_time),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Customer ID',
                controller: customerIdController,
                isNumber: false,
                prefixicon: Icon(Icons.person),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Transaction Amount',
                controller: transactionAmountController,
                isNumber: true,
                prefixicon: Icon(Icons.monetization_on),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Merchant Category Code',
                controller: merchantCategoryCodeController,
                isNumber: true,
                prefixicon: Icon(Icons.category),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Merchant Name',
                controller: merchantNameController,
                isNumber: false,
                prefixicon: Icon(Icons.store),
                obsecuretext: false),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Transaction Type',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.theme['ghostWhiteColor']),
                ),
                border: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.theme['ghostWhiteColor']),
                ),
              ),
              value: selectedTransactionType,
              dropdownColor: Colors.white,
              iconEnabledColor: Colors.blue,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold), // Text color
              items: [
                'Purchase',
                'Adjustment',
                'Payment',
                'Refund'
              ]
                  .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: TextStyle(color: Colors.black))))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTransactionType = value!;
                });
              },
            ),
            CustomTextFeild(
                hintText: 'Country Code',
                controller: countryCodeController,
                isNumber: true,
                prefixicon: Icon(Icons.flag),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Zip Code',
                controller: zipCodeController,
                isNumber: true,
                prefixicon: Icon(Icons.location_on),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Distance from Home',
                controller: distanceFromHomeController,
                isNumber: true,
                prefixicon: Icon(Icons.directions),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Time Since Previous Tx',
                controller: timeSincePrevTxController,
                isNumber: true,
                prefixicon: Icon(Icons.timer),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Daily Tx Count',
                controller: dailyTxCountController,
                isNumber: true,
                prefixicon: Icon(Icons.countertops),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Daily Tx Amount',
                controller: dailyTxAMTCountController,
                isNumber: true,
                prefixicon: Icon(Icons.countertops),
                obsecuretext: false),
            CustomTextFeild(
                hintText: 'Amount to Daily Ratio',
                controller: amountToDailyRatioController,
                isNumber: true,
                prefixicon: Icon(Icons.pie_chart),
                obsecuretext: false),
            CheckboxListTile(
              activeColor: AppColors.theme['primaryColor'],
              checkColor: Colors.white,
              title: const Text('Card Present'),
              value: cardPresent,
              onChanged: (value) {
                setState(() {
                  cardPresent = value!;
                });
              },
            ),
            CheckboxListTile(
              activeColor: AppColors.theme['primaryColor'],
              checkColor: Colors.white,
              title: const Text('Suspicious Merchant'),
              value: suspiciousMerchant,
              onChanged: (value) {
                setState(() {
                  suspiciousMerchant = value!;
                });
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              textSize: 16,
              height: 35,
              width: 150,
              textColor: Colors.white,
              bgColor: AppColors.theme['primaryColor'],
              onTap: () async {

                String label = await handleSubmit();

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

                final List<List<String>> csvData = [
                  columnNames,
                  [
                    timestampController.text,
                    customerIdController.text,
                    merchantNameController.text,
                    transactionAmountController.text,
                    merchantCategoryCodeController.text,
                    merchantNameController.text,
                    selectedTransactionType,
                    countryCodeController.text,
                    zipCodeController.text,
                    distanceFromHomeController.text,
                    timeSincePrevTxController.text,
                    dailyTxCountController.text,
                    dailyTxAMTCountController.text,
                    amountToDailyRatioController.text,
                    cardPresent ? "1" : "0",
                    suspiciousMerchant ? "1" : "0"
                  ]
                ];

                String csvString = const ListToCsvConverter().convert(csvData);
                final bytes = utf8.encode(csvString);
                final blob = html.Blob([bytes]);
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor = html.AnchorElement(href: url)
                  ..setAttribute("download", "input_data_${DateTime.now().toString()}.csv")
                  ..click();
                html.Url.revokeObjectUrl(url);

                UploadTask task = Config.storage.ref().child("hacknuthon6/files/input_data_${DateTime.now().toString()}.csv").putData(bytes) ;

                TaskSnapshot snapshot = await task;

                final downloadUrl = await snapshot.ref.getDownloadURL();

                // print("#downloadurl : $downloadUrl");

                List<String> columnNames2 = [
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

                final List<List<String>> csvData2 = [
                  columnNames2,
                  [
                    timestampController.text,
                    customerIdController.text,
                    merchantNameController.text,
                    transactionAmountController.text,
                    merchantCategoryCodeController.text,
                    merchantNameController.text,
                    selectedTransactionType,
                    countryCodeController.text,
                    zipCodeController.text,
                    distanceFromHomeController.text,
                    timeSincePrevTxController.text,
                    dailyTxCountController.text,
                    dailyTxAMTCountController.text,
                    amountToDailyRatioController.text,
                    cardPresent ? "1" : "0",
                    suspiciousMerchant ? "1" : "0",
                    label
                  ]
                ];

                String csvString2 = const ListToCsvConverter().convert(csvData2);
                final bytes2 = utf8.encode(csvString2);
                final blob2 = html.Blob([bytes2]);
                final url2 = html.Url.createObjectUrlFromBlob(blob2);
                final anchor2 = html.AnchorElement(href: url2)
                  ..setAttribute("download", "output_data_${DateTime.now().toString()}.csv")
                  ..click();
                html.Url.revokeObjectUrl(url);

                UploadTask task2 = Config.storage.ref().child("output_data_${DateTime.now().toString()}.csv").putData(bytes2) ;

                TaskSnapshot snapshot2 = await task2;

                final downloadUrl2 = await snapshot2.ref.getDownloadURL();

                // print(downloadUrl2);

                TransacationModel tmodel = TransacationModel(
                    timestamp: DateTime.now().toString(),
                    option: "Transaction",
                    inputCsvUrl: downloadUrl,
                    outputCsvUrl: downloadUrl2,
                    label: label,
                    id: ''
                );

                await TransactionApis.addTransaction(userProvider.user?.userID ?? "", tmodel);

                final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
                await fetchTransactionProvider.fetchHistory(context);

                setState(() {
                  isLoading = false;
                });


              },
              title: "Generate Report",
              isLoading: isLoading,
              loadWidth: 100,
            ),
          ],
        ),
      ) ;
    }) ;
  }
}
