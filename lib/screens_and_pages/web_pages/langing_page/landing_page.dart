import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/provider/fetch_transaction_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  static const route = "/";
  static const fullRoute = "/";
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState(){
    final fetchTransactionProvider = Provider.of<FetchTransactionProvider>(context, listen: false);
    fetchTransactionProvider.fetchHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is the landing page of the website'),
        ],
      ),
    );
  }
}
