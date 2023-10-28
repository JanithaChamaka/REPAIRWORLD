import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/login/login_main_screen.dart';
import 'package:myapp/login/reuse.dart';

import '../Screens/home_main.dart';

// ignore: use_key_in_widget_constructors
class CommLoginscreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CommLoginScreenState createState() => _CommLoginScreenState();
}

class _CommLoginScreenState extends State<CommLoginscreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // late DatabaseReference dbref;
  bool isRememberMe = false;
  final _formKey = GlobalKey<FormState>();

  Future<User?> _createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle any authentication exceptions (e.g., email already in use)

      print('Failed to create user: ${e.message}');

      return null;
    }
  }

  Future<void> _uploadUsernameToFirestore(User user, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('technicians')
          .doc(user.uid)
          .set({'email': email});
    } catch (e) {
      // Handle any Firestore upload exceptions

      print('Failed to upload username: $e');
    }
  }

  void _registerUserWithEmailAndPassword(BuildContext context) async {
    // Form is valid, save form fields
    if (_formKey.currentState!.validate()) {
      // Form is valid, save form fields
      _formKey.currentState!.save();

      String email = _email.text;
      String password = _password.text;

      User? user = await _createUserWithEmailAndPassword(email, password);

      if (user != null) {
        await _uploadUsernameToFirestore(
          user,
          email,
        );

        print('User registered successfully!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeMain()),
        );
      }
    }
  }


  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF5F5B5B),
                  blurRadius: 1,
                  offset: Offset(0, 0),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Can\'t be empty';
              }
              return null;
            },
            controller: _email,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Color(0xFF0E64D2),
              ),
              hintText: 'User Name',
              hintStyle: TextStyle(
                color: Color(0xFF5F5B5B),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF0E64D2),
                blurRadius: 1,
                offset: Offset(0, 0),
              )
            ],
          ),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'can\'t be empty';
              }
              return null;
            },
            controller: _password,
            obscureText: true,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.key,
                color: Color(0xFF0E64D2),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Color(0xFF5F5B5B),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildcPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF5F5B5B),
                  blurRadius: 1,
                  offset: Offset(0, 0),
                )
              ]),
          height: 60,
          child: const TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.key,
                  color: Color(0xFF0E64D2),
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Color(0xFF5F5B5B))),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 120),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Create an Account',
                            style: TextStyle(
                              color: Color(0xFF4F4F4F),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          buildUsername(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildPassword(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildcPassword(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildLoginBtn(context, false, () {
                            _registerUserWithEmailAndPassword(context);
                          }),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
