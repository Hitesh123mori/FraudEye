import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_home.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SidebarChart extends StatefulWidget {
  const SidebarChart({super.key});

  @override
  State<SidebarChart> createState() => _SidebarChartState();
}

class _SidebarChartState extends State<SidebarChart> {

  Map<String, int> data = {} ;


  @override
  void initState(){
    super.initState();
    data = getCategoryCounts(hd);
    // print(data) ;
  }

  Map<String, int> getCategoryCounts(List<List<String>> data) {

    Map<String, int> counts = {
      'Credit Card': 0,
      'Health Care': 0,
      'Authorized': 0,
      'Suspicious': 0,
      'Credit Card Safe': 0,
      'Credit Card Fraud': 0,
      'Health Care Safe': 0,
      'Health Care Fraud': 0,
    };

    for (var entry in data) {
      String category = entry[1];
      String status = entry[4].toLowerCase();
      // print(status);

      if (category == 'Credit Card') counts['Credit Card'] = (counts['Credit Card'] ?? 0) + 1;
      if (category == 'Health Care') counts['Health Care'] = (counts['Health Care'] ?? 0) + 1;
      if (status == 'authorized') counts['Authorized'] = (counts['Authorized'] ?? 0) + 1;
      if (status == 'suspicious') counts['Suspicious'] = (counts['Suspicious'] ?? 0) + 1;
      if (category == 'Credit Card' && status == 'authorized') counts['Credit Card Safe'] = (counts['Credit Card Safe'] ?? 0) + 1;
      if (category == 'Credit Card' && status == 'suspicious') counts['Credit Card Fraud'] = (counts['Credit Card Fraud'] ?? 0) + 1;
      if (category == 'Health Care' && status == 'authorized') counts['Health Care Safe'] = (counts['Health Care Safe'] ?? 0) + 1;
      if (category == 'Health Care' && status == 'suspicious') counts['Health Care Fraud'] = (counts['Health Care Fraud'] ?? 0) + 1;
    }

    return counts;
  }


  @override
  Widget build(BuildContext context) {

    final List<ChartData> overallData = [
      ChartData('Authorized', (data['Authorized']??0).toDouble(), Colors.lightBlue),
      ChartData('Suspicious', (data['Suspicious']??0).toDouble(), Colors.red),
    ];

    final List<ChartData> categoryFraudData = [
      ChartData('Credit Card', (data['Credit Card'] ?? 0).toDouble(), Colors.orange),
      ChartData('Health Care', (data['Health Care'] ?? 0).toDouble(), Colors.purple),
    ];

    final List<ChartData> categoryComparisonData = [
      ChartData('Credit Card - Safe', (data['Credit Card Safe'] ?? 0).toDouble(), Colors.lightBlue),
      ChartData('Credit Card - Fraud', (data['Credit Card Fraud'] ?? 0).toDouble(), Colors.red),
      ChartData('Health Care - Safe', (data['Health Care Safe'] ?? 0).toDouble(), Colors.lightBlue),
      ChartData('Health Care - Fraud', (data['Health Care Fraud'] ?? 0).toDouble(), Colors.red),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Chart Analysis",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChartContainer('Overall Fraud vs Safe Transactions', overallData),
                  SizedBox(width: 10),
                  _buildChartContainer('Fraud Distribution by Category', categoryFraudData),
                  SizedBox(width: 10),
                  _buildChartContainer('Fraud Rate Percentage by Category', [
                    ChartData(
                      'Credit Card Fraud',
                      ((data['Credit Card Fraud'] ?? 0).toDouble() /
                          ((data['Health Care Fraud'] ?? 0) + (data['Credit Card Fraud'] ?? 0)).toDouble()) * 100,
                      Colors.orange,
                    ),
                    ChartData(
                      'Health Care Fraud',
                      ((data['Health Care Fraud'] ?? 0).toDouble() /
                          ((data['Health Care Fraud'] ?? 0) + (data['Credit Card Fraud'] ?? 0)).toDouble()) * 100,
                      Colors.red,
                    ),

                  ]),
                ],
              ),
            ),
            Divider(),
            _buildBarChartContainer('Fraud vs Safe Transactions by Category', categoryComparisonData),
          ],
        ),
      ),
    );
  }

  Widget _buildChartContainer(String title, List<ChartData> data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.theme['backgroundColor'],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: 300,
      child: SfCircularChart(
        title: ChartTitle(
          text: title,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.theme['primaryColor'],
          ),
          alignment: ChartAlignment.near,
        ),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        series: <PieSeries<ChartData, String>>[
          PieSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartContainer(String title, List<ChartData> data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.theme['backgroundColor'],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SfCartesianChart(
        title: ChartTitle(
          text: title,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.theme['primaryColor'],
          ),
          alignment: ChartAlignment.near,
        ),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            name: 'Transactions',
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}