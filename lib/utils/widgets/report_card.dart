import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';

class ReportCard extends StatefulWidget {
  final String text;
  final String subtext;
  final Color color;
  final IconData icon;

  const ReportCard({
    super.key,
    required this.text,
    required this.subtext,
    required this.color,
    required this.icon,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  late Size mq; // Declare `mq` properly

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.theme['ghostWhiteColor'],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: widget.color.withOpacity(0.5),
            child: Icon(widget.icon, size: 28, color: widget.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtext,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: (){

            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.theme['op2'],
                ),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/other_images/pdf.png",
                            height: 30,
                            width: 30,
                          ),
                          Text("PDF",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )),
              ),
            ),
          ),

          SizedBox(
            width: 5,
          ),
          
          GestureDetector(
            onTap: (){

            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.theme['op2'],
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/other_images/csv.png",
                        height: 30,
                        width: 30,
                      ),
                      Text("CSV",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)
                    ],
                  ),
                )),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
