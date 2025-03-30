import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TableScreen extends StatefulWidget {
  final List<List<String>> data;

  const TableScreen({super.key, required this.data});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: Colors.black.withOpacity(0.1),
            width: 1.5,
          ),
          columns: [
            _customColumn('TimeStamp', 100),
            _customColumn('Option', 100),
            _customColumn('Input CSV', 200),
            _customColumn('Output CSV', 200),
            _customColumn('Label', 100),
          ],
          rows: widget.data.map((row) => DataRow(
            cells: row.asMap().entries.map((entry) {
              int index = entry.key;
              String cell = entry.value;

              if (index == 1) {
                return DataCell(_coloredOption(cell));
              }
              if (index == 2 || index == 3) {
                return DataCell(_downloadButton(cell));
              }
              if (index == 4) {
                return DataCell(_coloredLabel(cell));
              }

              return DataCell(
                SizedBox(
                  height: 50,
                  child: Center(child: Text(cell, textAlign: TextAlign.center)),
                ),
              );
            }).toList(),
          )).toList(),
        ),
      ),
    );
  }

  DataColumn _customColumn(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _coloredLabel(String label) {
    Color bgColor = label.toLowerCase() == "authorized" ? AppColors.theme['green'] : AppColors.theme['red'] ;
    return _coloredContainer(label, bgColor,false);
  }

  Widget _coloredOption(String option) {
    Color bgColor = option.toLowerCase() == "health care" ? AppColors.theme['op1'] :AppColors.theme['op2'];
    return _coloredContainer(option, bgColor,false);
  }

  Widget _coloredContainer(String text, Color bgColor,bool isWhite) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: isWhite ? Colors.white :Colors.black),
        ),
      ),
    );
  }

  Widget _downloadButton(String url) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 35,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/other_images/csv.png",height: 30,width: 30,),
              SizedBox(width: 5),
              Text(
                "Download",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
