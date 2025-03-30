import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/table_normal_user.dart';


List<List<String>> hd = [
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Health Care','url1 download','url2 download',"Authorized"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Health Care','url1 download','url2 download',"Authorized"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Authorized"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Health Care','url1 download','url2 download',"Authorized"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Authorized"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],
  ['10:22:22','Credit Card','url1 download','url2 download',"Suspicious"],

] ;


class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Resent Transactions",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 20,),

            TableScreen(data: hd),

          ],
        ),
      )
    );
  }
}
