import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/apis/init/config.dart';
import 'package:hack_nu_thon_6/model/bank_model.dart';
import 'package:hack_nu_thon_6/model/normal_user.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/utils/helper_functions/web_toast.dart';
import 'package:provider/provider.dart';

class AuthApi {

  static final _collectionRefAdmin = Config.firestore.collection("admins");
  static final _collectionRefNormal = Config.firestore.collection("normal_users");
  static final _collectionRefBank = Config.firestore.collection("bank_users");


  /// Sign In Method
  static Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {

      // Check in normal users
      bool isNormalUser = await userExistsEmail(email, 'normal_users');
      bool isBankUser = await userExistsEmail(email, 'bank_users');
      bool isadminUser = await userExistsEmail(email, 'admins');

      if (!isNormalUser && !isBankUser && !isadminUser) {
        WebToasts.showToastification(
            "Error", "User not found!", Icon(Icons.error, color: Colors.red), context);
        return;
      }

      await Config.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      WebToasts.showToastification(
          "Confirmation", "Login Successful!",
          Icon(Icons.check_circle_outline, color: Colors.green), context);

      final routerProvider = Provider.of<RouterProvider>(context, listen: false);
      routerProvider.isLoginEnabled = false;

      if (isNormalUser) {
        context.go('/home-user');
      } else if(isadminUser){
        context.go('/dashboard');
      }else{
        context.go('/home-bank');
      }

    } on FirebaseAuthException catch (e) {
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    } catch (e) {
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    }
  }

  static Future<void> signUp(
      BuildContext context, String email, String password, String name, bool isBank) async {
    try {
      bool emailExistsInNormal = await userExistsEmail(email, 'normal_users');
      bool emailExistsInBank = await userExistsEmail(email, 'bank_users');

      if (emailExistsInNormal || emailExistsInBank) {
        WebToasts.showToastification(
            "Error", "This email is already in use.",
            Icon(Icons.error, color: Colors.red), context);
        return;
      }

      UserCredential userCredential =
      await Config.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (isBank) {
        await createBankUser(userCredential, email, name);
      } else {
        await createNormalUser(userCredential, email, name);
      }

      final routerProvider = Provider.of<RouterProvider>(context, listen: false);

      WebToasts.showToastification(
          "Confirmation", "Registration Successful!",
          Icon(Icons.check_circle_outline, color: Colors.green), context);

      routerProvider.isLoginEnabled = false;

      context.go(isBank ? '/home-bank' : '/home-user');

    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }
      WebToasts.showToastification(
          "Error", errorMessage, Icon(Icons.error, color: Colors.red), context);
    } catch (e) {
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    }
  }

  /// Create Normal User
  static Future<void> createNormalUser(
      UserCredential userCredential, String email, String name) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final normalUser = NormalUser(
      userID: userCredential.user?.uid,
      name: name,
      email: email,
      createAt: time,
    );

     await _collectionRefNormal
        .doc(userCredential.user!.uid)
        .set(normalUser.toJson());
  }

  /// Create Bank User
  static Future<void> createBankUser(
      UserCredential userCredential, String email, String name) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final bankUser = BankModel(
      bankID: userCredential.user?.uid,
      name: name,
      email: email,
      createAt: time,
    );

    await _collectionRefBank
        .doc(userCredential.user!.uid)
        .set(bankUser.toJson());
  }



  /// Check if User Exists in Firestore
  static Future<bool> userExistsEmail(String email, String collection) async {
    final querySnapshot = await Config.firestore
        .collection(collection)
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  /// Check if User Exists in Firestore by ID
  static Future<bool> userExistsById(String userId, String collection) async {
    final docSnapshot =
    await Config.firestore.collection(collection).doc(userId).get();

    return docSnapshot.exists;
  }


  /// Get User Details from Firestore based on Role
  static Future<dynamic> getUserById(String userId, String role) async {
    try {
      DocumentSnapshot docSnapshot;

      if (role == "ADMIN") {
        docSnapshot = await _collectionRefAdmin.doc(userId).get();
        print(userId);
      } else if (role == "BANK") {
        docSnapshot = await _collectionRefBank.doc(userId).get();
      } else {
        docSnapshot = await _collectionRefNormal.doc(userId).get();
      }

      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (error, stackTrace) {
      return {
        "error": error.toString(),
        "stackTrace": stackTrace.toString(),
      };
    }
  }



}
