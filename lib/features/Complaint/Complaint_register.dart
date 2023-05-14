import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();
  List<String> complaints = [];

  void _submitComplaint() async {
    if (_formKey.currentState?.validate() == true) {
      // Add the complaint to the Firestore collection
      final user = _auth.currentUser;
      await _firestore.collection('complaints').add({
        'user_id': user?.uid,
        'complaint_text': _complaintController.text,
        'status': 'Pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the text field
      _complaintController.clear();

      // Show a dialog to confirm the complaint submission
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Complaint submitted'),
          content: Text('Your complaint has been registered.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Dismiss the dialog
                Navigator.of(context).pop();

                // Navigate to the view complaints page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintList(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Complaint Box'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/crbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 420),
                    TextFormField(
                      controller: _complaintController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your complaint',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your complaint';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.black38),
                      ),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: _submitComplaint,
                    ),


                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ComplaintList()),
                        );
                      },
                      child: Text("View Your Complaints", style: TextStyle(color: Colors.black),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ComplaintList extends StatefulWidget {
  @override
  _ComplaintListState createState() => _ComplaintListState();
}
class _ComplaintListState extends State<ComplaintList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> complaints = [];

  @override
  void initState() {
    super.initState();
    _getComplaints();
  }

  Future<void> _getComplaints() async {
    QuerySnapshot snapshot = await _firestore.collection('complaints').get();
    List<DocumentSnapshot> documents = snapshot.docs;

    setState(() {
      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String complaint = data['complaint_text'] as String;
        complaints.add(complaint);
      }
    });
  }
  void _deleteComplaint(int index) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    // Check that the user is logged in
    if (user == null) {
      return;
    }

    // Get the complaint document
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('complaints')
        .get();
    final DocumentSnapshot complaintDocument = snapshot.docs[index];

    // Check that the complaint exists
    if (!complaintDocument.exists) {
      return;
    }

    // Check that the user has permission to delete the complaint
    if ((complaintDocument.data() as Map<String, dynamic>)['user_id'] != user.uid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Denied'),
            content: Text('You do not have permission to delete this complaint.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Delete the complaint
    await complaintDocument.reference.delete();

    // Update the list of complaints
    setState(() {
      complaints.removeAt(index);
    });
  }

  void _checkStatus(int index) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('complaints')
        .get();
    final DocumentSnapshot complaintDocument = snapshot.docs[index];

    if (!complaintDocument.exists) {
      return;
    }

    final Map<String, dynamic> data =
    complaintDocument.data() as Map<String, dynamic>;
    String status = data['status'] as String;

    // Check if the user is an admin
    final User? user = FirebaseAuth.instance.currentUser;
    if (user?.email == 'admin@gmail.com') {
      // Display the dialog to update the status
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Complaint Status'),
            content: StatefulBuilder(builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current status: $status'),
                  SizedBox(height: 16),
                  Text('Update status:'),
                  SizedBox(height: 8),
                  DropdownButton<String>(
                    value: status,
                    onChanged: (String? newValue) {
                      setState(() {
                        status = newValue!;
                      });
                    },
                    items: <String>['Pending', 'Working', 'Resolved']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('UPDATE'),
                onPressed: () async {
                  // Update the status in the Firestore collection
                  await complaintDocument.reference.update({'status': status});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Display the status to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Complaint Status'),
            content: Text('$status'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Complaints',
        ),
      ),
      body: Container(
        color: Colors.black,
        child: complaints?.isEmpty ?? true
            ? Center(
            child: Image.asset(
              'assets/crbg2.png',
              fit: BoxFit.cover,
            )
        )
            : ListView.builder(
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shadowColor: Colors.indigo.shade100,
                  color: Colors.indigo.shade100,
                  margin: EdgeInsets.all(20),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Complaint:',
                              style: TextStyle(
                                color: Colors.indigo.shade700,
                              ),
                            ),
                            IconButton(
                              color: Colors.red.withOpacity(0.7),
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteComplaint(index),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          complaints[index],
                          style: TextStyle(fontSize: 33, ),
                        ),
                        TextButton(
                          child: Text('Status', style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),),
                          onPressed: () => _checkStatus(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}