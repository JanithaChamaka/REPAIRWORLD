import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../side_menu_content/flutter_toast.dart';

class Module {
  final String remindID;
  final String title;
  final String note;
  final String date;
  final String time;
  final String remind;
  Module({
    required this.remindID,
    required this.title,
    required this.note,
    required this.date,
    required this.time,
    required this.remind,
  });
}

class usersearchPage extends StatefulWidget {
  const usersearchPage({Key? key}) : super(key: key);

  @override
  State<usersearchPage> createState() => _usersearchPageState();
}

int notificationCount = 5;

class _usersearchPageState extends State<usersearchPage> {
  
  final firestoreInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  List<Module> remind = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchModulesData();
    super.initState();
  }

  Future<void> _refreshData() async {
    await fetchModulesData();
  }

  List<String> imagePaths = [
    'assets/images/io.png',
    'assets/images/dev.png',
    'assets/images/dev.png',
    'assets/images/io.png',
  ];

  List<String> itemTexts = [
    'hi,', // Include the userName using string interpolation
    'Google I/O 2023',
    'Google I/O 2023',
    'Google I/O 2023',
  ];

  List<String> itemTexts1 = [
    'Google  2023',
    'Google  2023',
    'Google I/O 2023',
    'Google I/O 2023',
  ];
  // List<bool> containerFavorites = [false, false, false, false];
  bool isReactClicked = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,

        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Relevent Technicians', // Add your desired text here
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 0),
                      Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagePaths.length,
                            itemBuilder: (BuildContext context, int index) {
                              // bool isReactClicked = false;

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [

                                          const SizedBox(height: 10),
                                          Text(
                                            itemTexts1[index],
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF00744A),
                                            ),
                                          ),
                                          Text(
                                            'district and province ',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF00744A),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Positioned(

                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              // Technician's Picture
                                                              CircleAvatar(
                                                                radius: 40,
                                                                backgroundImage: AssetImage('technician_image.jpg'), // Replace with the actual image path
                                                              ),
                                                              SizedBox(height: 10),

                                                              // Technician's Name
                                                              Text(
                                                                '$remind',
                                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                              ),
                                                              SizedBox(height: 5),

                                                              // Expertise Area
                                                              Text(remind[index].title),

                                                              // Living Area
                                                              Text('Living Area: Your Living Area'),

                                                              // About Me
                                                              Text(
                                                                'About Me:',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              Text('In this code, you create a custom AlertDialog with a Column containing the technicians picture, name, expertise area, living area, description, and the "Continue" button. You should replace technician_image.jpg with the actual path to the technicians image and customize the text and data as needed.'),

                                                              SizedBox(height: 10),

                                                              // Continue Button
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: Text('Confirm Booking'),
                                                                        content: Text('Are you sure you want to confirm the booking?'),
                                                                        actions: [
                                                                          Builder(
                                                                            builder: (BuildContext innerContext) {
                                                                              return ElevatedButton(
                                                                                onPressed: () {
                                                                                  Navigator.push(
                                                                                    innerContext,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => const usersearchPage(),
                                                                                    ),
                                                                                  );
                                                                                  Navigator.of(innerContext).pop(); // Close the dialog
                                                                                },
                                                                                child: Text('Book'),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.blue,
                                                                ),
                                                                child: Text('Continue'),
                                                              ),

                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                  ),
                                                  child: Text(
                                                    'book',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      color:
                                                      const Color(0xFF00744A),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                      const SizedBox(height: 0),
                      Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagePaths.length,
                            itemBuilder: (BuildContext context, int index) {
                              // bool isReactClicked = false;

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [

                                          const SizedBox(height: 10),
                                          Text(
                                            itemTexts1[index],
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '$remind',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF00744A),
                                            ),
                                          ),
                                          Text(
                                            remind[index].title,
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF00744A),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Positioned(

                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              // Technician's Picture
                                                              CircleAvatar(
                                                                radius: 50,
                                                                backgroundImage: AssetImage('technician_image.jpg'), // Replace with the actual image path
                                                              ),
                                                              SizedBox(height: 10),

                                                              // Technician's Name
                                                              Text(
                                                                'Technician Name',
                                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                              ),
                                                              SizedBox(height: 5),

                                                              // Expertise Area
                                                              Text('Expertise Area: Your Expertise Area'),

                                                              // Living Area
                                                              Text('Living Area: Your Living Area'),

                                                              // About Me
                                                              Text(
                                                                'About Me:',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              Text('Your description goes here.'),

                                                              SizedBox(height: 10),

                                                              // Continue Button
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  // Perform some action here
                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.white,
                                                                ),
                                                                child: Text('Continue'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                  ),
                                                  child: Text(
                                                    'book',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      color:
                                                      const Color(0xFF00744A),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchModulesData() async {
    try {
      final technicians = await firestoreInstance
          .collection("technicians")
          .get();

      List<Module> remindItem = technicians.docs.map((doc) {
        return Module(
          remindID: doc.id,
          title: doc.get("email"),
          note: doc.get("expertise"),
          date: doc.get("province"),
          time: doc.get("district"),
          remind: doc.get("username"),
        );
      }).toList();


      remind.addAll(remindItem);

      // Update the widget state to reflect the changes
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      AppToastmsg.appToastMeassage('Error fetching modules data!');
    }
  }
}

//
