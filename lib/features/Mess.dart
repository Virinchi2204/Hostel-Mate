import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyMess extends StatefulWidget {
  const MyMess({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyMessState createState() => _MyMessState();
}

class _MyMessState extends State<MyMess> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/design.png"),
          fit: BoxFit.cover,
        ),
      ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

              GestureDetector(
              onTap: () async {},
          child: Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.shade100.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset.zero,
                ),
              ],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exposure_minus_1,
                  size: 50,
                  color: Colors.indigo.shade200,
                ),
              ],
            ),
          ),
        ),

        SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.shade100.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset.zero,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dining_outlined,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          Text( 'Spoons',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.shade100.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset.zero,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.plus_one,
                            size: 50,
                            color: Colors.indigo.shade200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exposure_minus_1,
                          size: 50,
                          color: Colors.indigo.shade200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Text( 'Plates',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.plus_one,
                          size: 50,
                          color: Colors.indigo.shade200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exposure_minus_1,
                          size: 50,
                          color: Colors.indigo.shade200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_drink_outlined,
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Text( 'Glasses',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade100.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.cyan.shade100.withOpacity(0.5), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.plus_one,
                          size: 50,
                          color: Colors.indigo.shade200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
    ],
          ),
        ),
      ),
    );
  }
}