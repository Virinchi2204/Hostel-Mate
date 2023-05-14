import 'package:flutter/material.dart';
import 'package:jahnavi/screens/login.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);


  Widget _selectedFeatures(BuildContext context, String name, String page, IconData icon) {
  String routeName = page;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.shade200,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset.zero,
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.indigo.shade50, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        //image: DecorationImage(
           // image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){},
            child: const Icon(
              color: Colors.white,
              Icons.menu,
            ),
          ),
          title: Image.asset('assets/logo.jpg',height: 40,width: 60,alignment: Alignment.center),
          actions:[
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'profile');
              },
              child: const Icon(
                color: Colors.white,
                Icons.account_circle_outlined,
              ),
            )
          ),
          ],
        ),

        body:SafeArea(
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  /*image: DecorationImage(
                    image: AssetImage('assets/design.png'),
                    fit: BoxFit.cover,
                  ),*/
                ),
                height: 270,
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/design.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Text(
                                             'Welcome to Hostel Mate',
                                             style: TextStyle(
                                                 fontSize: 30,
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.bold)
                                         ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'To make your life at hostel much easier',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.indigo.shade50,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Hostel Mate at your Service', style: TextStyle(
                      fontSize: 30, color: Colors.indigo.shade50, fontWeight: FontWeight.bold,
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Container(
                        height: 500,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.30,
                          children: [
                            _selectedFeatures(context, 'Laundromat','laundromat_availability_check', Icons.local_laundry_service_rounded),
                            _selectedFeatures(context, 'SOS', 'SOS', Icons.warning_amber_rounded),
                            _selectedFeatures(context, 'ChatBox', 'Chat_box', Icons.groups),
                            _selectedFeatures(context, 'Mess', 'Mess', Icons.dining_outlined),
                            _selectedFeatures(context, 'Complaint', 'Complaint_register', Icons.assignment),
                            _selectedFeatures(context, 'trial', 'trial', Icons.bus_alert_outlined),
                            //_selectedFeatures('Canteen'),
                          ],
                        ),
                      ),

                    )
                  ],
                )
              )
            ],
          ),
        ),
        ),
      );

  }
}