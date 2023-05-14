/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jahnavi/screens/home.dart';
import 'package:jahnavi/screens/login.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  bool isLoging = false;
  User? get user => _user.value;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(Duration(seconds: isLoging ? 0 : 2), () {
      if (user == null) {
        isLoging = false;
        update();
        Get.offAll(() => const MyLogin());
      } else {
        isLoging = true;
        update();
        Get.offAll(() => const MyHome());
      }
    });
  }

  void registerUser(BuildContext context, name, email, password) async {
    try {
      isLoging = true;
      update();
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
      Navigator.pushNamed(context, 'home');
      await collectionReference.add({'Name': name});
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar("Account Creating Failed", e);
    }
  }

  void login(BuildContext context, email, password) async {
    try {
      isLoging = true;
      update();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, 'home');
      getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar("Login Failed", e);
    }
  }

  void forgotPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      getSuccessSnackBar("Reset mail sent successfully. Check mail!");
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar("Error", e);
    }
  }

  getErrorSnackBar(String message, _) {
    Get.snackbar(
      "Error",
      "$message\n${_.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD05045),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getErrorSnackBarNew(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD05045),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  void signOut() async {
    await auth.signOut();
  }
}
