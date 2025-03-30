import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SidebarChart extends StatefulWidget {
  const SidebarChart({super.key});

  @override
  State<SidebarChart> createState() => _SidebarChartState();
}

class _SidebarChartState extends State<SidebarChart> {
  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<ChartData> overallData = [
      ChartData('Safe', 6, Colors.lightBlue),
      ChartData('Fraud', 2, Colors.red),
    ];

    final List<ChartData> categoryFraudData = [
      ChartData('Credit Card', 1, Colors.orange),
      ChartData('Health Care', 1, Colors.purple),
    ];

    final List<ChartData> categoryComparisonData = [
      ChartData('Credit Card - Safe', 5, Colors.lightBlue),
      ChartData('Credit Card - Fraud', 1, Colors.red),
      ChartData('Health Care - Safe', 1, Colors.lightBlue),
      ChartData('Health Care - Fraud', 1, Colors.red),
    ];

    return SingleChildScrollView( // FIX: Prevents overflow
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Chart Analysis",style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  Container(
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
                        text: 'Overall Fraud vs Safe Transactions',
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['primaryColor'],
                        ),
                        alignment: ChartAlignment.near,
                      ),
                      legend: Legend(isVisible: true,position: LegendPosition.bottom),
                      series: <PieSeries<ChartData, String>>[
                        PieSeries<ChartData, String>(
                          dataSource: overallData,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(width: 10,),
              
                  Container(

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
                        text: 'Fraud Distribution by Category',
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['primaryColor'],
                        ),
                        alignment: ChartAlignment.near,
                      ),
                      legend: Legend(isVisible: true,position: LegendPosition.bottom),
                      series: <PieSeries<ChartData, String>>[
                        PieSeries<ChartData, String>(
                          dataSource: categoryFraudData,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(width: 10,),
              
                  Container(
                    height: 300,
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
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: 'Fraud Rate Percentage by Category',
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['primaryColor'],
                        ),
                        alignment: ChartAlignment.near,
                      ),
                      legend: Legend(isVisible: true,position: LegendPosition.bottom),
                      series: <PieSeries<ChartData, String>>[
                        PieSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Credit Card Fraud', 16.7, Colors.orange),
                            ChartData('Health Care Fraud', 50.0, Colors.red),
                          ],
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),

            Divider(),

            Container(
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
                  text: 'Fraud vs Safe Transactions by Category',
                  textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.theme['primaryColor'],
                  ),
                  alignment: ChartAlignment.near,
                ),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                legend: Legend(isVisible: true,position: LegendPosition.bottom),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: categoryComparisonData,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) => data.color,
                    name: 'Transactions',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            )

          ],
        ),
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
