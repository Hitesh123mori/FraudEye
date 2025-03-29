import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Some",style: GoogleFonts.ebGaramond(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: AppColors.theme['primaryColor'],fontSize: 25),),
        Text("Text",style: GoogleFonts.ebGaramond(fontWeight: FontWeight.bold,color: AppColors.theme['primaryColor'],fontSize: 25),)
      ],
    );
  }
}