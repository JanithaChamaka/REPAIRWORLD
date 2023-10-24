import 'package:flutter/material.dart';

class TechniciansDisplayPage extends StatelessWidget {
  final List<TechnicianDetails> technicians;

  TechniciansDisplayPage({required this.technicians});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technicians'),
      ),
      body: ListView.builder(
        itemCount: technicians.length,
        itemBuilder: (context, index) {
          return TechnicianCard(technician: technicians[index]);
        },
      ),
    );
  }
}

class TechnicianDetails {
  final String name;
  final String expertise;
  final String province;
  final String district;
  final String city;

  TechnicianDetails({
    required this.name,
    required this.expertise,
    required this.province,
    required this.district,
    required this.city,
  });
}

class TechnicianCard extends StatelessWidget {
  final TechnicianDetails technician;

  TechnicianCard({required this.technician});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technician Name:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              technician.name,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'Expertise:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              technician.expertise,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'Province:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              technician.province,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'District:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              technician.district,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'City:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              technician.city,
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

