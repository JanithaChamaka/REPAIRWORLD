import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  UserProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Text("User not found");
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('User Profile', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text('Username: ${userData['username']}'),
                      Text('Email: ${userData['email']}'),
                      Text('Province: ${userData['province']}'),
                      Text('District: ${userData['district']}'),
                      Text('Expertise: ${userData['expertise']}'),
                    ],
                  ),
                ),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
