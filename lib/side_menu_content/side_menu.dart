import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';
import 'menu_items.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<Map<String, dynamic>?> fetchUserData(User user) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('technicians')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        return userData.data();
      } else {
        AppToastmsg.appToastMeassage('User data not found in Firestore');
        return null;
      }
    } catch (e) {
      AppToastmsg.appToastMeassage('Failed to fetch user data: $e');

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<Map<String, dynamic>?>(
              future: fetchUserData(user!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final userData = snapshot.data;
                  String username = userData!['username'] ?? '...';
                  String email = userData['email'] ?? '...';

                  return UserAccountsDrawerHeader(
                    accountName: Text(username),
                    accountEmail: Text(email),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          'https://xsgames.co/randomusers/assets/avatars/male/77.jpg',
                          // loadingBuilder: (context, child, loadingProgress) {
                          //   if (loadingProgress == null) return child;
                          //   return CircularProgressIndicator(
                          //     value: loadingProgress.expectedTotalBytes !=
                          //             null
                          //         ? loadingProgress.cumulativeBytesLoaded /
                          //             (loadingProgress.expectedTotalBytes ??
                          //                 1)
                          //         : null,
                          //   );
                          // },
                          // errorBuilder: (context, error, stackTrace) {
                          //   return const CircularProgressIndicator();
                          // },
                        ),
                      ),
                    ),
                  );
                }
              }),
          AppMenuItem(
            icon: "exam",
            title: "Exam",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingsMain(),
              //   ),
              // );
            },
          ),
          AppMenuItem(
            icon: "card",
            title: "Payments",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const PaymentsMain(),
              //   ),
              // );
            },
          ),
          AppMenuItem(
            icon: "settings",
            title: "Settings",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //    // builder: (context) => const SettingsMain(),
              //   ),
              // );
            },
          ),
          AppMenuItem(
            icon: "enq",
            title: "Enquiry Center",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingsMain(),
              //   ),
              // );
            },
          ),
          AppMenuItem(
            icon: "help",
            title: "Help",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingsMain(),
              //   ),
              // );
            },
          ),
          AppMenuItem(
            icon: "out",
            title: "Log Out",
            onTap: signOut,
          )
        ],
      ),
    );
  }
}
