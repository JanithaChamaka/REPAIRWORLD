import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screens/Home_user_main.dart';
import 'package:myapp/firebase/Auth_state_change.dart';
import 'package:myapp/login/Get_stated.dart';

import 'Screens/tecall.dart';
import 'Screens/user_serach_main.dart';
import 'login/login_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LoginPage',
        debugShowCheckedModeBanner: false,
        home: usersearchPage(),
        //Loginscreen(),
        );
  }
}
