import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:hack_nu_thon_6/utils/widgets/text_feild/custom_text_feild.dart';

class ManuallyFormScreen extends StatefulWidget {
  const ManuallyFormScreen({super.key});

  @override
  State<ManuallyFormScreen> createState() => _ManuallyFormScreenState();
}

class _ManuallyFormScreenState extends State<ManuallyFormScreen> {

  bool isLoading = false;

  final TextEditingController timestampController = TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController transactionAmountController = TextEditingController();
  final TextEditingController merchantCategoryCodeController = TextEditingController();
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController distanceFromHomeController = TextEditingController();
  final TextEditingController timeSincePrevTxController = TextEditingController();
  final TextEditingController dailyTxCountController = TextEditingController();
  final TextEditingController amountToDailyRatioController = TextEditingController();

  String selectedTransactionType = 'Purchase';
  bool cardPresent = false;
  bool suspiciousMerchant = false;

  void handleSubmit() {
    print('Timestamp: ${timestampController.text}');
    print('Customer ID: ${customerIdController.text}');
    print('Transaction Amount: ${transactionAmountController.text}');
    print('Merchant Category Code: ${merchantCategoryCodeController.text}');
    print('Merchant Name: ${merchantNameController.text}');
    print('Transaction Type: $selectedTransactionType');
    print('Country Code: ${countryCodeController.text}');
    print('Zip Code: ${zipCodeController.text}');
    print('Distance from Home: ${distanceFromHomeController.text}');
    print('Time Since Previous Tx: ${timeSincePrevTxController.text}');
    print('Daily Tx Count: ${dailyTxCountController.text}');
    print('Amount to Daily Ratio: ${amountToDailyRatioController.text}');
    print('Card Present: $cardPresent');
    print('Suspicious Merchant: $suspiciousMerchant');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("This is for credit card fraud detection only.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          CustomTextFeild(hintText: 'Timestamp (MM:SS.t)', controller: timestampController, isNumber: false, prefixicon: Icon(Icons.access_time), obsecuretext: false),
          CustomTextFeild(hintText: 'Customer ID', controller: customerIdController, isNumber: false, prefixicon: Icon(Icons.person), obsecuretext: false),
          CustomTextFeild(hintText: 'Transaction Amount', controller: transactionAmountController, isNumber: true, prefixicon: Icon(Icons.monetization_on), obsecuretext: false),
          CustomTextFeild(hintText: 'Merchant Category Code', controller: merchantCategoryCodeController, isNumber: true, prefixicon: Icon(Icons.category), obsecuretext: false),
          CustomTextFeild(hintText: 'Merchant Name', controller: merchantNameController, isNumber: false, prefixicon: Icon(Icons.store), obsecuretext: false),

          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Transaction Type',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['ghostWhiteColor']),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['ghostWhiteColor']),
              ),
            ),
            value: selectedTransactionType,
            dropdownColor: Colors.white,
            iconEnabledColor: Colors.blue,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Text color
            items: ['Purchase', 'Cash Advance', 'Adjustment', 'Payment', 'Refund']
                .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.black))))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedTransactionType = value!;
              });
            },
          ),


          CustomTextFeild(hintText: 'Country Code', controller: countryCodeController, isNumber: true, prefixicon: Icon(Icons.flag), obsecuretext: false),
          CustomTextFeild(hintText: 'Zip Code', controller: zipCodeController, isNumber: true, prefixicon: Icon(Icons.location_on), obsecuretext: false),
          CustomTextFeild(hintText: 'Distance from Home', controller: distanceFromHomeController, isNumber: true, prefixicon: Icon(Icons.directions), obsecuretext: false),
          CustomTextFeild(hintText: 'Time Since Previous Tx', controller: timeSincePrevTxController, isNumber: true, prefixicon: Icon(Icons.timer), obsecuretext: false),
          CustomTextFeild(hintText: 'Daily Tx Count', controller: dailyTxCountController, isNumber: true, prefixicon: Icon(Icons.countertops), obsecuretext: false),
          CustomTextFeild(hintText: 'Amount to Daily Ratio', controller: amountToDailyRatioController, isNumber: true, prefixicon: Icon(Icons.pie_chart), obsecuretext: false),

          CheckboxListTile(
            activeColor:AppColors.theme['primaryColor'],
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
            activeColor:AppColors.theme['primaryColor'],
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
            onTap: () {
              handleSubmit();
            },
            title: "Generate Report",
            isLoading: isLoading,
            loadWidth: 40,
          ),

        ],
      ),
    );
  }
}

