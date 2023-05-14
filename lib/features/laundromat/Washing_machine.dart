import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MyWM extends StatefulWidget {
  const MyWM({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyWMState createState() => _MyWMState();
}

class _MyWMState extends State<MyWM> {

  showAlertDialog(BuildContext context, name) {
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
      backgroundColor: Colors.indigo.shade200,
      title: Text("Alert", style: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold,
      ),),
      content: Text("This machine is already booked by $name", style: TextStyle(
        color: Colors.white,
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
  //Widget _machine( String no) {
    Widget _machine(String no) {
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('washing_machines')
              .doc(no)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            bool isBooked = snapshot.data!.get('booked');
            String userEmail = FirebaseAuth.instance.currentUser!.email!;
            String Bookedby = snapshot.data?.get('bookedBy');
            bool isCurrentUserBooked = Bookedby == userEmail;
            return GestureDetector(
              onTap: () async {
                try {
                  FirebaseFirestore firestore = await FirebaseFirestore.instance;
                  CollectionReference washing_machines = await firestore.collection('washing_machines');
                  //await washing_machines.doc(no).update({'booked': !isBooked});
                 // await washing_machines.doc(no).update({'booked_by': ''});
                  if (isBooked) {
                    String userEmail = FirebaseAuth.instance.currentUser!.email!;
                    String Bookedby = snapshot.data?.get('bookedBy');
                    bool isCurrentUserBooked = Bookedby == userEmail;
                    if(Bookedby != userEmail)
                    {showAlertDialog(context, Bookedby);}
                    else
                    {await washing_machines.doc(no).update({'booked': false, 'bookedBy': ''});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Machine unbooked successfully!'),
                      ),
                    );
                    }
                  } else {
                    String userEmail = FirebaseAuth.instance.currentUser!.email!;
                    await washing_machines.doc(no).update(
                        {'booked': true, 'bookedBy': userEmail});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            'Machine booked successfully!', style: TextStyle(color: Colors.white),),
                      ),
                    );
                  }
                }
                catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error booking/unbooking machine!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  print(e.toString());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isBooked
                      ? (isCurrentUserBooked ? Colors.orange : Colors.red)
                      : Colors.green,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 50,
                      width: 150,
                      child: Icon(
                        isBooked ? Icons.lock : Icons.lock_open,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 90,
                      width: 150,
                      child: Icon(
                        Icons.local_laundry_service_outlined,
                        size: 100,
                        color: Colors.white,
                      ),

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      no,
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
          });
    }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      'Laundromat', style: TextStyle(
                        fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 70,
                      ),
                      child: Container(
                        height: 700,
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.7,
                          children: [
                            _machine('001'),
                            _machine('002'),
                            _machine('003'),
                            _machine('004'),
                            _machine('005'),
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
}}
