import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;
  String userName = '';
  String province = '';
  String district = '';
  String faultDescription = '';
  String electronicDevice = '';

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      _firestore.collection('users').doc(currentUser!.uid).get().then((doc) {
        if (doc.exists) {
          setState(() {
            userName = doc['name'];
            province = doc['province'];
            district = doc['district'];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Customer Details', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Name: $userName'),
            Text('Province: $province'),
            Text('District: $district'),
            SizedBox(height: 20),
            Text('Fault Description', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Fault Description',
              ),
              onChanged: (value) {
                setState(() {
                  faultDescription = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Electronic Device', style: TextStyle(fontSize: 20)),
            // Add your electronic device selection widgets here
            // For example:
            DropdownButton<String>(
              value: electronicDevice,
              onChanged: (value) {
                setState(() {
                  electronicDevice = value!;
                });
              },
              items: ['Device 1', 'Device 2', 'Device 3']
                  .map((device) {
                return DropdownMenuItem(
                  value: device,
                  child: Text(device),
                );
              })
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle chat button click
                // You can navigate to a chat screen here
              },
              child: Text('Chat with Support'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Accept' button click
                  },
                  child: Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Decline' button click
                  },
                  child: Text('Decline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
