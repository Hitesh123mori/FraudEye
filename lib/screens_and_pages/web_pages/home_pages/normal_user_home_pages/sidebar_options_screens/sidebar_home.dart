import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/helper_widgets/table_normal_user.dart';
import 'package:provider/provider.dart';


class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {

  Future<void> fetchTransactions()async{

    final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
    await fetchTransactionProvider.fetchHistory(context);

  }

  @override
  void initState(){
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchTransactionProvider>(builder: (context,traProvider,child){
      return Container(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Resent Transactions",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 20,),

                TableScreen(data: traProvider.recentHistory),

              ],
            ),
          )
      );
    });
  }
}
