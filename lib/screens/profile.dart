import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jahnavi/auth/profile_controller.dart';

import '../auth/auth_controller.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}
class Constants{
  static const String dummyAvatar = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200";
}
class _MyProfileState extends State<MyProfile> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _animationImage, _animationCamera;

  @override
  void initState() {
    super.initState();
    Get.put(ProfileController());
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animationImage = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.4)).animate(_animationController);
    _animationCamera = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.1)).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));
    String? picUrl = AuthController.instance.user!.photoURL;
    picUrl = picUrl ?? Constants.dummyAvatar;
    String? name = AuthController.instance.user!.displayName ?? "No Name";
    String? email = AuthController.instance.user!.email;
    String? mobile = AuthController.instance.user!.phoneNumber ?? "0000000000";
    mobileController.text = mobile;
    nameController.text = name;
    emailController.text = email.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                  _animationController.forward();
                } else if (notification.metrics.pixels == notification.metrics.minScrollExtent) {
                  _animationController.reverse();
                }
                print(notification.metrics.pixels);
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Obx(
                          () {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            readOnly: ProfileController.instance.isEdit.value,
                            initialValue: name,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                  ),
                                  child: const Icon(
                                    Icons.person_outline,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  ProfileController.instance.toggleEdit();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        initialValue: email,
                        readOnly: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text("Mobile", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Obx(
                          () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          initialValue: mobile,
                          readOnly: ProfileController.instance.isEdit.value,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                ProfileController.instance.toggleEdit();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text('DOCUMENTATION'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListTile(
                        leading: const Icon(
                          Icons.privacy_tip_outlined,
                          size: 20,
                        ),
                        title: const Text(
                          'Privacy Policy',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListTile(
                        leading: const Icon(
                          Icons.share,
                          size: 20,
                        ),
                        title: const Text(
                          'Share',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: Colors.red,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          AuthController.instance.signOut();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: MediaQuery.of(context).size.width * 0.5 - 60,
              child: SlideTransition(
                position: _animationImage,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: picUrl,
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 170,
              left: MediaQuery.of(context).size.width * 0.5 + 20,
              child: SlideTransition(
                position: _animationCamera,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}