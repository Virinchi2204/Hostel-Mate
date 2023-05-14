import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jahnavi/auth/auth_controller.dart';
import 'package:jahnavi/details.dart';
import 'package:jahnavi/features/laundromat/Dryers.dart';
import 'package:jahnavi/screens/home.dart';
import 'package:jahnavi/screens/login.dart';
import 'package:jahnavi/screens/profile.dart';
import 'package:jahnavi/screens/register.dart';
import 'package:jahnavi/screens/splash.dart';
import 'package:jahnavi/features/laundromat/laundromat_availability_check.dart';

import 'features/Chat_box.dart';
import 'features/Complaint/Complaint_register.dart';
import 'features/Mess.dart';
import 'features/SOS.dart';
import 'features/laundromat/Washing_machine.dart';
import 'features/trial.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
    routes: {
      'home': (context) => const MyHome(),
      //'details': (context) => const MyDetails(),
      'register': (context) => const MyRegister(),
      'login': (context) => const MyLogin(),
      'profile': (context) => const MyProfile(),
      'laundromat_availability_check': (context) => const MyLaundromat(),
      'SOS': (context) => MySOS(),
      'Complaint_register': (context) => ComplaintForm(),
      'Chat_box': (context) => const MyChat(),
      'Washing_machine': (context) => const MyWM(),
      'Dryers': (context) => const MyD(),
      'Mess': (context) => const MyMess(),
      'trial': (context) => const Mytrial(),
    },
  ));
}