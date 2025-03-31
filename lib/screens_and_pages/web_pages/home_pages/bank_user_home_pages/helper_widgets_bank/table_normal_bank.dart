import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TableNormalBank extends StatefulWidget {
  final List<List<String>> data;

  const TableNormalBank({super.key, required this.data});

  @override
  State<TableNormalBank> createState() => _TableNormalBankState();
}

class _TableNormalBankState extends State<TableNormalBank> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.1),
            width: 1.5,
          ),
          columns: [
            _customColumn('TimeStamp', 150),
            _customColumn('User', 150),
            _customColumn('Option', 150),
            _customColumn('Input CSV', 200),
            _customColumn('Output CSV', 200),
            _customColumn('Label', 120),
          ],
          rows: widget.data.map((row) => DataRow(
            cells: row.asMap().entries.map((entry) {
              int index = entry.key;
              String cell = entry.value;

              if (index == 2) {
                return DataCell(_coloredOption(cell)); // Option color handling
              }
              if (index == 3 || index == 4) {
                return DataCell(_downloadButton(cell)); // Download buttons for CSV links
              }
              if (index == 5) {
                return DataCell(_coloredLabel(cell)); // Label color handling
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
    Color bgColor = (label.toLowerCase() == "authorized")
        ? (AppColors.theme['green'] ?? Colors.green)
        : (AppColors.theme['red'] ?? Colors.red);

    return _coloredContainer(label, bgColor, true);
  }

  Widget _coloredOption(String option) {
    Color bgColor = (option.toLowerCase() == "health care")
        ? (AppColors.theme['op1'] ?? Colors.blue)
        : (AppColors.theme['op2'] ?? Colors.orange);

    return _coloredContainer(option, bgColor, true);
  }

  Widget _coloredContainer(String text, Color bgColor, bool isWhite) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: isWhite ? Colors.black : Colors.black),
        ),
      ),
    );
  }

  Widget _downloadButton(String url) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.download, size: 15, color: AppColors.theme['primaryColor'] ?? Colors.blue),
              const SizedBox(width: 5),
              Text(
                "Download",
                style: TextStyle(color: AppColors.theme['primaryColor'] ?? Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
