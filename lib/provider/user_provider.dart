import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/apis/admin_user_apis/admin_user_apis.dart';
import 'package:hack_nu_thon_6/apis/auth_apis/auth_apis.dart';
import 'package:hack_nu_thon_6/apis/bank_user_apis/bank_user_apis.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/apis/normal_user_apis/normal_user_apis.dart';
import 'package:hack_nu_thon_6/model/admin_user.dart';
import 'package:hack_nu_thon_6/model/bank_model.dart';
import 'package:hack_nu_thon_6/model/normal_user.dart';


class UserProvider extends ChangeNotifier {

  NormalUser? user;
  BankModel? bank;
  AdminUser? admin;
  bool isUser = false;
  bool isBank = false;
  bool isAdmin = false;


  void notify() {
    notifyListeners();
  }

  Future initUser() async {

    String? uid = Config.auth.currentUser?.uid;

    try{
      isBank = await AuthApi.userExistsById(uid ?? "","bank_users") ;
      isAdmin = await AuthApi.userExistsById(uid ?? "","admins") ;
      isUser = await AuthApi.userExistsById(uid ?? "","normal_users") ;
    }catch(e){
      print(e) ;
    }

     if(isBank){
       bank = BankModel.fromJson(await BankUserApis.getUserById(uid ?? "")) ;
       print("bank : $bank") ;
     }else if(isAdmin){
       admin = AdminUser.fromJson(await AdminUserApis.getUserById(uid ?? ""));
       print("admin : $admin") ;
     }else if(isUser){
       user = NormalUser.fromJson(await NormalUserApis.getUserById(uid ?? ""));
       print("user : $user") ;
     }

    notifyListeners();

    log("#initUser complete");
  }

  Future logOut() async {
    await Config.auth.signOut();
    user = null;
    bank = null ;
    admin = null;
    notifyListeners();
  }



  bool isLoggedInUser() {

    return (user != null && Config.auth.currentUser != null) ;

  }

  bool isLoggedInBank() {
    return (bank != null  && Config.auth.currentUser != null);
  }
  bool isLoggedInAdmin() {
    return (admin != null && Config.auth.currentUser != null);
  }


}