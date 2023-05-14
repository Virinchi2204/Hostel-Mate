import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jahnavi/auth/auth_controller.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';

class Mytrial extends StatefulWidget {
  const Mytrial({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MytrialState createState() => _MytrialState();
}

class _MytrialState extends State<Mytrial> {


  showAlertDialog(BuildContext context, text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(
          color: Colors.amberAccent

      ),),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog box
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Alert", style: TextStyle(
        color: Colors.indigo.shade400, fontWeight: FontWeight.bold,
      ),),
      content: Text(text, style: TextStyle(
        color: Colors.indigo,
      ),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _bus(String slot, String time) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('buses')
          .doc(slot)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        bool isAvailable = data['available'];
        String userEmail = FirebaseAuth.instance.currentUser!.email!;

        return GestureDetector(
          onTap: () async {
            if (userEmail == 'admin@gmail.com') {
              bool newAvailability = !isAvailable;
              await FirebaseFirestore.instance
                  .collection('buses')
                  .doc(slot)
                  .update({'available': newAvailability});
            } else {
              if (!isAvailable && userEmail != 'admin@gmail.com') {
                showAlertDialog(context, 'Sorry, you missed the bus');
              } else if (isAvailable && userEmail != 'admin@gmail.com') {
                showAlertDialog(context, 'The bus will leave on time be ready');
              }
                // Get the current position of the admin
                /*Position adminPosition = await Geolocator.getCurrentPosition();

                // Show the Google Map with the admin's live location
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Live Location of Admin'),
                    ),
                    body: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(adminPosition.latitude, adminPosition.longitude),
                        zoom: 14.0,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('admin'),
                          position: LatLng(adminPosition.latitude, adminPosition.longitude),
                          infoWindow: InfoWindow(title: 'Admin'),
                        ),
                      },
                    ),
                  ),
                ));
              }*/
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isAvailable ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Schedule',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 50,
                      width: 150,
                      child: Icon(
                        isAvailable
                            ? Icons.bus_alert_rounded
                            : Icons.bus_alert_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 145,
                    ),
                    Container(
                      child: Icon(
                        isAvailable
                            ? Icons.access_time_filled_outlined
                            : Icons.access_time_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
    ),
    child: Scaffold(
    backgroundColor: Colors.indigo.shade200,
    body: SafeArea(
    child: ListView(
    children: [
    Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 30,
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    'Shuttle Bus Schedule', style: TextStyle(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(
    top: 70,
    ),
    child: Container(
    height: 800,
    child: GridView.count(
    crossAxisCount: 1,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
    childAspectRatio: 4,
    children: [

      _bus('slot1', '8:30AM'),
      _bus('slot2', '11:00AM'),
      _bus('slot3', '1:00PM'),
      _bus('slot4', '3:00PM'),
      _bus('slot5', '5:00PM'),
      _bus('slot6', '6:00PM'),
    ],
    ),
    ),
    )
    ],
    ),
    )
    ],
    ),
    ),
    ),
    );
    }
    }
