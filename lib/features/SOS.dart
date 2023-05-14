import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class MySOS extends StatefulWidget {
  MySOS({Key? key}) : super(key: key);

  @override
  _MySOSState createState() => _MySOSState();
}

class _MySOSState extends State<MySOS> {
  Location _location = Location();
  String _locationMessage = "";
  List<String> _contacts = [];

  Future<Widget> _sendSOSMessage() async {
    try {
      LocationData locationData = await _location.getLocation();
      String message =
          "SOS! I'm in danger. My current location is:\nhttps://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

      await sendSMS(
        message: message,
        recipients: _contacts,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("SOS message sent successfully"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: Could not send SOS message"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        title: const Text('Distress Signal'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        //decoration: const BoxDecoration(
         // image: DecorationImage(
         //   image: AssetImage('assets/distresssignalbackground.jpeg'),
         //   fit: BoxFit.cover,
        //  ),
        //),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(_contacts.join(", ")),
              SizedBox(height: 32),
              MaterialButton(
                onPressed: _sendSOSMessage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 64.0,
                      color: Colors.white,
                    ),
                    Text(
                      "SEND SOS",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                shape: CircleBorder(),
                padding: EdgeInsets.all(64.0),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectContacts() async {
    PhoneContact contacts = await FlutterContactPicker.pickPhoneContact();
    //(shouldOpenNativeContactsApp: true);
    setState(() {
      _contacts = [contacts.phoneNumber!].cast<String>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        title: const Text(
          'Distress Signal',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/distresssignalbackground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              Text(_contacts.join(", ")),
              SizedBox(height: 32),
              MaterialButton(
                color: Colors.purple.shade200,
                onPressed: _sendSOSMessage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                    Text(
                      "SEND SOS",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                shape: CircleBorder(),
                padding: EdgeInsets.all(80.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
