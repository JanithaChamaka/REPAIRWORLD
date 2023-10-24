import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screens/user_serach_main.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technician Search App'),
      ),
      body: DeviceFaultForm(),
    );
  }
}

class DeviceFaultForm extends StatefulWidget {
  @override
  _DeviceFaultFormState createState() => _DeviceFaultFormState();
}

class _DeviceFaultFormState extends State<DeviceFaultForm> {
  String? selectedDevice;
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedCategory;
  String? faultDescription;

  Future<void> saveFormDataToFirestore() async {
    try {
      final CollectionReference deviceFaultCollection =
          FirebaseFirestore.instance.collection('device_faults');

      final Map<String, dynamic> formData = {
        'selectedDevice': selectedDevice,
        'selectedCategory': selectedCategory,
        'selectedProvince': selectedProvince,
        'selectedDistrict': selectedDistrict,
        'faultDescription': faultDescription,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await deviceFaultCollection.add(formData);

      print('Data saved to Firestore successfully');
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Report a Device Fault',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            builddropbtn(
              'Select Device',
              ['Lap', 'TV', 'Desktop', 'Radio'],
            ),
            SizedBox(height: 20.0),
            builddropbtn(
              'Select Category',
              ['Category 1', 'Category 2', 'Category 3'],
            ),
            SizedBox(height: 20.0),
            builddropbtn(
              'Select Province',
              [
                'Central Province',
                'Eastern Province',
                'Northern Province',
                'North Central Province',
                'North Western Province',
                'Sabaragamuwa Province',
                'Southern Province',
                'Uva Province',
                'Western Province',
              ],
            ),
            SizedBox(height: 20.0),
            builddropbtn(
              'Select District',
              [
                'District 1',
                'District 2',
                'District 3',
              ],
            ),
            SizedBox(height: 20.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  faultDescription = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Fault Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                searchTechnicians();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const usersearchPage(),
                  ),
                );
              },
              child: Text('Search Technicians'),
            ),
          ],
        ),
      ),
    );
  }

  Widget builddropbtn(String hintText, List<String> dropdownOptions) {
    String? selectedOption;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF5F5B5B),
            blurRadius: 1,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        onChanged: (newValue) {
          setState(() {
            selectedOption = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Can\'t be empty';
          }
          return null;
        },
        items: dropdownOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.account_circle_outlined,
            color: Color(0xFF0E64D2),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF5F5B5B),
          ),
        ),
      ),
    );
  }

// ... Existing imports ...

  void searchTechnicians() {
    FirebaseFirestore.instance
        .collection('technicians')
        .where('selectedDevice', isEqualTo: selectedDevice)
        .where('selectedCategory', isEqualTo: selectedCategory)
        .where('selectedProvince', isEqualTo: selectedProvince)
        .where('selectedDistrict', isEqualTo: selectedDistrict)
        .get()
        .then((querySnapshot) {
      List<String> technicians = [];

      querySnapshot.docs.forEach((document) {
        final data = document.data() as Map<String, dynamic>;
        technicians.add(data[
            'technicianName']); // Replace with the actual field containing technician names
      });

      // Navigate to the TechniciansDisplayPage and pass the technicians data
      // Navigator.push(
      //   // context,
      //   // MaterialPageRoute(
      //   //   builder: (context) => TechniciansDisplayPage(technicians: technicians),
      //   // ),
      // );
    }).catchError((error) {
      print('Error searching for technicians: $error');
    });
  }
}
