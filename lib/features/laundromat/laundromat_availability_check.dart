import 'package:flutter/material.dart';

class MyLaundromat extends StatefulWidget {
  const MyLaundromat({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLaundromatState createState() => _MyLaundromatState();
}

class _MyLaundromatState extends State<MyLaundromat> {

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
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'Washing_machine');
              },
              child: Container(
                height: 250,
                width: 180,
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
                      Icons.local_laundry_service_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text( 'Washing Machine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'Dryers');
              },
              child: Container(
                height: 250,
                width: 180,
                child: Container(
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
                  children:  [
                    Icon(
                      Icons.dry_cleaning_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text('Dryer',
                      style: TextStyle(
                        color: Colors.white,
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}