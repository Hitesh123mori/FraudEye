import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/main.dart';
import 'package:hack_nu_thon_6/provider/normal_user_sidebar_provider.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_chart.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_fraud.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_home.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_report.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/sidebar_options_screens/sidebar_trash.dart';
import 'package:hack_nu_thon_6/utils/logo.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/sidebar/sidebar_item.dart';
import 'package:provider/provider.dart';

import 'helper_widgets/custom_dialog_box.dart';

class NormalUserHome extends StatefulWidget {
  static const route = "/home-user";
  static const fullRoute = "/home-user";
  const NormalUserHome({super.key});

  @override
  State<NormalUserHome> createState() => _NormalUserHomeState();
}

class _NormalUserHomeState extends State<NormalUserHome> {
  void init(UserProvider userProvider) async {
    await userProvider.initUser();
  }

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    init(userProvider);
  }
  // void _showLoginAlert(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: AppColors.theme['backgroundColor'],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         title: Text("Not Logged In", style: TextStyle(fontWeight: FontWeight.bold)),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
  //             SizedBox(height: 10),
  //             Text("You are not logged in. Please log in to continue."),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               final routerProvider = Provider.of<RouterProvider>(context, listen: false);
  //               Future.delayed(Duration.zero, () {
  //                 context.go('/login');
  //               });
  //               routerProvider.isLoginEnabled = true;
  //             },
  //             child: Text("Go to Login", style: TextStyle(color: AppColors.theme['primaryColor'])),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer2<UserProvider,NormalUserSidebarProvider>(builder: (context, userProvider,sidebarProvider, child) {
      return Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          body: Row(
            children: [

              ///part 1
              Container(
                width: 250,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.theme['secondaryColor']
                            .withOpacity(0.2))),
                child: Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14.0,),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         ///logo here
                         Container(
                           height: 40,
                           width: mq.width * 0.4,
                           decoration: BoxDecoration(
                             color: AppColors.theme['primaryColor'],
                             borderRadius: BorderRadius.circular(10),
                           ),
                           // child: Logo(),
                         ),

                         SizedBox(height: 10,),

                         /// add button here
                       MouseRegion(
                         cursor: SystemMouseCursors.click,
                         child: GestureDetector(
                           onTap: () {

                             showCustomDialog(context);

                           },
                           child: Container(
                             height: 50,
                             width: 100,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: AppColors.theme['backgroundColor'],
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black.withOpacity(0.2),
                                   blurRadius: 6,
                                   offset: const Offset(2, 2),
                                 ),
                               ],
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.add),
                                 SizedBox(width: 8),
                                 Text("ADD"),
                               ],
                             ),
                           ),
                         ),
                       ),

                       Divider(),
                       ],
                     ),
                   ),

                    // sidebar menus
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SidebarItem(
                                optionKey: "home",
                                onTap: () => Provider.of<NormalUserSidebarProvider>(context, listen: false).updateCurrent("home"),
                                icon: Icons.home_outlined,
                                text: 'Home',
                                role :"user"
                              ),
                              SidebarItem(
                                optionKey: "chart",
                                onTap: () => Provider.of<NormalUserSidebarProvider>(context, listen: false).updateCurrent("chart"),
                                icon: Icons.add_chart,
                                text: 'Chart Analysis',
                                  role :"user"
                              ),
                              SidebarItem(
                                optionKey: "reports",
                                onTap: () => Provider.of<NormalUserSidebarProvider>(context, listen: false).updateCurrent("reports"),
                                icon: Icons.file_copy_outlined,
                                text: 'Reports',
                                  role :"user"
                              ),
                              SidebarItem(
                                optionKey: "frauds",
                                onTap: () => Provider.of<NormalUserSidebarProvider>(context, listen: false).updateCurrent("frauds"),
                                icon: Icons.report_gmailerrorred,
                                text: 'Frauds',
                                  role :"user"
                              ),
                              SidebarItem(
                                optionKey: "trash",
                                onTap: () => Provider.of<NormalUserSidebarProvider>(context, listen: false).updateCurrent("trash"),
                                icon: Icons.delete_outline_outlined,
                                text: 'Trash',
                                  role :"user"
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),

              ///part 2
              Expanded(
                child: Container(
                  child: Column(
                    children: [

                      ///search bar and profile
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.theme['secondaryColor']
                                    .withOpacity(0.2))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              SizedBox(height: 100,),

                              //search field
                              Container(
                                height: 50,
                                width: mq.width * 0.4,
                                decoration: BoxDecoration(
                                  color: AppColors.theme['primaryColor'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  child: Theme(
                                    data: ThemeData(
                                        textSelectionTheme: TextSelectionThemeData(
                                            selectionHandleColor:
                                            AppColors.theme['primaryColor'],
                                            cursorColor: AppColors.theme['primaryColor'],
                                            selectionColor:
                                            AppColors.theme['primaryColor'].withOpacity(0.3))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                                        hintText: "Search transaction here",
                                        hintStyle: TextStyle(color: Colors.black),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Icon(Icons.search, color: Colors.black),
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Icon(Icons.filter_list, color: Colors.black),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                              ),

                              CustomPopup(
                                barrierColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                content: Container(
                                  height: 100,
                                  width: 250,
                                  color: AppColors.theme['backgroundColor'],
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                child: Text(userProvider.user?.name?[0] ??"",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                                backgroundColor: AppColors.theme['primaryColor'].withOpacity(0.6),
                                              ),
                                              SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(userProvider.user?.name ?? "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                  Text(userProvider.user?.email ?? "",style: TextStyle(fontSize: 14),),
                                                ],
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                child:MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Text(userProvider.user?.name?[0] ??"",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                    backgroundColor: AppColors.theme['primaryColor'].withOpacity(0.6),
                                  ),
                                )
                              ),

                            ],
                          ),
                        ),
                      ),


                      /// data here
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //history here

                              if(sidebarProvider.current=="home")
                                SidebarHome(),

                              if(sidebarProvider.current=="chart")
                                SidebarChart(),

                              if(sidebarProvider.current=="reports")
                                SidebarReport(),

                              if(sidebarProvider.current=="frauds")
                                SidebarFraud(),

                              if(sidebarProvider.current=="trash")
                                SidebarTrash(),

                            ],
                          ),
                        ),
                      )
                      ),

                    ],
                  ),
                ),
              )


            ],
          ));
    });
  }


  ///dialog box
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialogBox(),
    );
  }

}

