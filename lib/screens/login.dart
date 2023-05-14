import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jahnavi/auth/auth_controller.dart';
import 'package:jahnavi/screens/register.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            //Container(),
            /*Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Hostel\nMate',
                style: TextStyle(color: Colors.white, fontSize: 60 ),
              ),
            ),*/
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 350,
                   // top: MediaQuery.of(context).size.height * 0.5
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              'Hostel Mate',
                              style: TextStyle(color: Colors.white, fontSize: 60 ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                prefixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.email_rounded)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: passwordController,
                            style: const TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                prefixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.lock_rounded)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),

                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                            onPressed: () {
                              //Navigator.pushNamed(context, 'home');
                              AuthController.instance.login(context, emailController.text.trim(), passwordController.text.trim());

                            },
                            child: Container(
                            width: 150,
                            height: 50,
                            child: const Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          ),


                          const SizedBox(
                            height: 150,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  //Navigator.pushNamed(context, 'register');
                                  Get.to(const MyRegister());
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                              ),
                              TextButton(
                                onPressed: () {
                                  //Navigator.pushNamed(context, 'register');
                                  Get.defaultDialog(
                                    title: "Forgot Password?",
                                    content: TextFormField(
                                        style: const TextStyle(color: Colors.black),
                                        controller: forgotEmailController,
                                        decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                          hintText: "Email address",
                                          hintStyle: const TextStyle(color: Colors.black38),
                                          fillColor: Colors.grey,
                                          filled: true,
                                        ),
                                    ),
                                          radius: 25,
                                          onWillPop: () {
                                                  forgotEmailController.text = "";
                                                  return Future.value(true);
                                },
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    confirm: ElevatedButton(
    onPressed: () {
    AuthController.instance.forgotPassword(forgotEmailController.text.trim());
    forgotEmailController.text = "";
    Get.back();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    disabledForegroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    ),
    ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "Send Reset Mail",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot password',
                                  textAlign: TextAlign.right,
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