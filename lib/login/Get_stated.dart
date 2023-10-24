import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/login/Select_user.dart';
//import 'package:myapp/login/Select_user.dart';
import 'package:myapp/login/login_main_screen.dart';

class getStated extends StatelessWidget {
  const getStated({Key? key}) : super(key: key);

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Form(
                    //key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Repair World',
                          style: TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Get connected to ',
                          style: TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'reliable professionals',
                          style: TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 350,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(200,
                                  50), // Set your desired width and height here
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue), // Set button background color
                          ),
                          onPressed: () {
                            // Navigate to the home screen when the "Login" button is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => selectuser()),
                            );
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
