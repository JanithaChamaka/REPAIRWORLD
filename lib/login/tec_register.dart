import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Screens/home_main.dart';
import 'package:myapp/login/login_main_screen.dart';

import '../Screens/Home_user_main.dart';
import 'login_tec.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedExpertise;

  final List<String> provinces = [
    'Central Province',
    'Eastern Province',
    'Northern Province',
    'North Central Province',
    'North Western Province',
    'Sabaragamuwa Province',
    'Southern Province',
    'Uva Province',
    'Western Province',
  ];

  final List<String> districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya',
  ];

  final List<String> expertise = ['Lap', 'TV', 'Desktop', 'Radio'];

  // Future<void> _registerUser() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: _emailController.text, password: _passwordController.text);
  //
  //     // Store user data in Firebase Firestore
  //     await FirebaseFirestore.instance
  //         .collection('technicians')
  //         .doc(userCredential.user!.uid)
  //         .set({
  //       'username': _usernameController.text,
  //       'email': _emailController.text,
  //       'province': _selectedProvince,
  //       'district': _selectedDistrict,
  //       'expertise': _selectedExpertise,
  //     });
  //
  //     // Navigate to another page to display technicians
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => TechnicianListPage()),
  //     // );
  //   } catch (e) {
  //     print('Error registering user: $e');
  //   }
  // }

  Future<User?> _createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle any authentication exceptions (e.g., email already in use)
      print(e);
      return null;
    }
  }

  Future<void> _uploadUsernameToFirestore(
    User user,
    String username,
    String email,
    String province,
    String district,
    String expertise,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('technicians')
          .doc(user.uid)
          .set({
        'username': username,
        'email': email,
        'province': province,
        'district': district,
        'expertise': expertise,
      });
    } catch (e) {
        print(e);
    }
  }

  void _registerUserWithEmailAndPassword() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _usernameController.text;
    String province = _selectedProvince!;
    String district = _selectedDistrict!;
    String expertise = _selectedExpertise!;

    User? user = await _createUserWithEmailAndPassword(email, password);
    if (user != null) {
      // User created successfully, now upload the username to Firestore
      await _uploadUsernameToFirestore(
          user, username, email, province, district, expertise);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeUserMain()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedProvince,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                  });
                },
                items: provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Province'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a province';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                items: districts.map((district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'District'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a district';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedExpertise,
                onChanged: (newValue) {
                  setState(() {
                    _selectedExpertise = newValue;
                  });
                },
                items: expertise.map((expertise) {
                  return DropdownMenuItem<String>(
                    value: expertise,
                    child: Text(expertise),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Expertise'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select an expertise';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUserWithEmailAndPassword();
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => tecLoginscreen()));
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
