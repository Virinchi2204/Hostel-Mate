import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jahnavi/auth/auth_controller.dart';
import 'package:jahnavi/auth/input_validator.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 200,
                    //top: MediaQuery.of(context).size.height * 0.28
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          const Text(
                            ' Create Your\n    Account\n',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),

                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                filled: true,
                                hintText: "Name",
                                hintStyle: const TextStyle(color: Colors.black38),
                                prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.account_box_rounded), color: Colors.black38),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(color: Colors.black38),
                                prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.mail_rounded),),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                filled: true,
                                hintText: "Create Password",
                                hintStyle: const TextStyle(color: Colors.black38),
                                prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.lock), color: Colors.black38),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: confirmpasswordController,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(color: Colors.black38),
                                prefixIcon: const Icon(Icons.lock_clock_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                            ElevatedButton(

                              onPressed: () async {
    if (InputValidator.validateField("Name", nameController.text.trim()) &&
    InputValidator.validateField("Email", emailController.text.trim())) {
    if (InputValidator.validatePassword(passwordController.text, confirmpasswordController.text)) {
    AuthController.instance
        .registerUser(context,nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
    //Navigator.pushNamed(context, 'details');
    //AuthController.instance.registerUser(context, emailController.text.trim(), passwordController.text.trim());
    }}
    },
                              style: ElevatedButton.styleFrom(

                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),

                              ),
                              child: Container(
                                width: 150,
                                height: 50,
                                child: const Center(
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),

                    ),

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'details');
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),*/
                          const SizedBox(
                            height: 50,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  //Navigator.pushNamed(context, 'login');
                                  Get.back();
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Log In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
