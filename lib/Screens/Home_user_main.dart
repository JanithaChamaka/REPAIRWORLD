import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app_Bar/app_bar_menu.dart';
import 'package:myapp/side_menu_content/flutter_toast.dart';
import 'package:myapp/side_menu_content/side_menu.dart';

class HomeUserMain extends StatefulWidget {
  const HomeUserMain({super.key});

  @override
  State<HomeUserMain> createState() => _HomeUserMainState();
}

class _HomeUserMainState extends State<HomeUserMain> {
  int notificationCount = 5;
  String userName = '';
  String expertise = '';
  double availableBalance = 0.00;
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserDate();
  }

  Future<void> getUserDate() async {
    try {
      final userData =
          await firestore.collection('technicians').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          userName = userData['username'];
          expertise = userData['expertise'];
        });
      } else {
        AppToastmsg.appToastMeassage('User data not found in Firestore');
      }
    } catch (e) {
      AppToastmsg.appToastMeassage('Failed to fetch user data: $e');
    }
  }

  String capitalizeFirstName(String name) {
    List<String> item = name.split(' ');
    String input = item[0];
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  // List<String> imagePaths = [
  //   'assets/images/io.png', // Replace with the actual path to your image assets
  //   'assets/images/dev.png',
  //   'assets/images/micro.png',
  //   'assets/images/io.png',
  // ];

  List<String> itemTexts = [
    'Google I/O 2023', // Replace with the desired text for each item
    'Google I/O 2023',
    'Google I/O 2023',
    'Google I/O 2023',
  ];

  List<String> itemTexts1 = [
    'Google  2023', // Replace with the desired text for each item
    'Google  2023',
    'Google I/O 2023',
    'Google I/O 2023',
  ];
  // List<bool> containerFavorites = [false, false, false, false];
  bool isReactClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithMenu(
          title: 'Home',
        ),
        drawer: const SideMenu(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(children: [
                  Center(
                    child: Container(
                      height: 150,
                      width: 370,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF69D199), Colors.white],
                            // Replace Colors.blue with your desired second color
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3),
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  ' Hi, $userName',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: const Color(0xff4F4F4F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0),
                          Text(
                            ' technician: $expertise',
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF18A689),
                            ),
                          ),
                          const SizedBox(height: 0),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(height: 20),
                  // Add some spacing between the first and second containers

                  // Second Container
                  SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Appointments', // Add your desired text here
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                                child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: itemTexts.length,
                              itemBuilder: (BuildContext context, int index) {
                                bool isReactClicked =
                                    false; // Track if the React button is clicked

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // ClipRRect(
                                            //   borderRadius:
                                            //       BorderRadius.circular(20),
                                            //   child: Image.asset(
                                            //     imagePaths[index],
                                            //     height: 100,
                                            //     width: 140,
                                            //     fit: BoxFit.cover,
                                            //   ),
                                            // ),
                                            const SizedBox(height: 10),
                                            Text(
                                              itemTexts[index],
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Subtitle Text',
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: const Color(0xFF00744A),
                                              ),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isReactClicked =
                                                            !isReactClicked;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      (isReactClicked == true)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: (isReactClicked ==
                                                              true)
                                                          ? Colors.red
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // Handle the "More" button click to navigate to another display
                                                        // You can use Navigator.push here
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        // ignore: deprecated_member_use
                                                        primary: Colors.white,
                                                        // shadowColor: Colors.transparent,
                                                        //  shape: RoundedRectangleBorder(
                                                        //    borderRadius: BorderRadius.only(
                                                        //      bottomLeft: Radius.circular(20),
                                                        //      bottomRight: Radius.circular(20),
                                                        //    ),
                                                        //  ),
                                                      ),
                                                      child: Text(
                                                        'More',
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: const Color(
                                                              0xFF00744A),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                          ])),
                  const SizedBox(height: 20),
                  // Add some spacing between the first and second containers

                  // Second Container
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Upcoming Activity', // Add your desired text here
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemTexts.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool isReactClicked =
                                  false; // Track if the React button is clicked

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // ClipRRect(
                                          //   borderRadius:
                                          //       BorderRadius.circular(20),
                                          //   child: Image.asset(
                                          //     imagePaths[index],
                                          //     height: 100,
                                          //     width: 140,
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
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
                                            'Subtitle Text',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF00744A),
                                            ),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isReactClicked =
                                                          !isReactClicked;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    (isReactClicked == true)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color:
                                                        (isReactClicked == true)
                                                            ? Colors.red
                                                            : Colors.black,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  bottom: 0,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Handle the "More" button click to navigate to another display
                                                      // You can use Navigator.push here
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      // ignore: deprecated_member_use
                                                      primary: Colors.white,
                                                      // shadowColor: Colors.transparent,
                                                      //  shape: RoundedRectangleBorder(
                                                      //    borderRadius: BorderRadius.only(
                                                      //      bottomLeft: Radius.circular(20),
                                                      //      bottomRight: Radius.circular(20),
                                                      //    ),
                                                      //  ),
                                                    ),
                                                    child: Text(
                                                      'More',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const Color(
                                                            0xFF00744A),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ))
                        ]),
                  )
                ]))));
  }
}
//
