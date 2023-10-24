import 'package:flutter/material.dart';
import 'package:myapp/login/login_main_screen.dart';
import 'package:myapp/login/tec_register.dart';

class selectuser extends StatelessWidget {
  const selectuser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardButton(
              title: 'Customer',
              image: AssetImage(
                  'assets/Images/01.png'), // Replace with your image asset
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loginscreen2()));
              },
            ),
            SizedBox(height: 40), // Add spacing between buttons
            CardButton(
              title: 'Technician',
              image: AssetImage(
                  'assets/Images/02.png'), // Replace with your image asset
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()));// Handle button 2 press
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final ImageProvider<Object> image;
  final VoidCallback onPressed;
  final double imageSize;
  final double WimageSize;
  final double titleFontSize;
  const CardButton({
    required this.title,
    required this.image,
    this.imageSize = 200.0,
    this.WimageSize = 300.0,
    this.titleFontSize = 20.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize, // Set the title font size
                  fontWeight:
                      FontWeight.bold, // You can adjust other properties here
                ),
              ),
            ),
            Image(
                width: WimageSize, // Set image width
                height: imageSize,
                // Set image height
                image: image), // Display the image below the title
          ],
        ),
      ),
    );
  }
}
