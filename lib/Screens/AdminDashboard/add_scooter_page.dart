import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddScooterPage extends StatefulWidget {
  @override
  _AddScooterPageState createState() => _AddScooterPageState();
}

class _AddScooterPageState extends State<AddScooterPage> {
List<Map<String, dynamic>> scooterData = [];
  List<Map<String, dynamic>> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = List.from(scooterData);
    _fetchScooters();
  }
Future<void> _fetchScooters() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('scooters').get();
    scooterData = snapshot.docs.map((doc) {
      print("Fetched Document ID: ${doc.id}"); // Document ID ko print karein
      return {
        'id': doc.id, // Firestore document ID
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
    setState(() {
      filteredData = List.from(scooterData); // Initialize filtered data
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to fetch scooters: $e')),
    );
  }
}

Future<void> _updateScooter(String id, Map<String, dynamic> updatedData) async {
  try {
    await FirebaseFirestore.instance.collection('scooters').doc(id).update(updatedData);
    _fetchScooters(); // Refresh data after updating
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scooter updated successfully!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update scooter: $e')),
    );
  }
}

void _deleteScooter(String id) {
  print("Deleting document with ID: $id");
  FirebaseFirestore.instance.collection('scooters').doc(id).delete().then((_) {
    setState(() {
      scooterData.removeWhere((item) => item['id'] == id);
      filteredData = List.from(scooterData); // Update filtered data
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scooter deleted successfully!')),
    );
  }).catchError((e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete scooter: $e')),
    );
  });
}

void _filterScooters(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredData = List.from(scooterData);
      } else {
        filteredData = scooterData.where((scooter) {
          return scooter.values.any((value) =>
              value.toString().toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
    });
  }
  // Future<void> saveScooterToFirebase(Map<String, dynamic> scooter) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('scooters').doc(scooter['id'])
  //         .add(scooter);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Scooter added successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to add scooter: $e')),
  //     );
  //   }
  // }
  void _addScooter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildScooterDialog();
      },
    );
  }

  void _editScooter(Map<String, dynamic> scooter) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildScooterDialog(scooter: scooter);
      },
    );
  }

  Widget _buildScooterDialog({Map<String, dynamic>? scooter}) {
    TextEditingController nameController =
    TextEditingController(text: scooter?['name']);
    TextEditingController qrCodeController =
    TextEditingController(text: scooter?['qrCode']);
    TextEditingController mileageController =
    TextEditingController(text: scooter?['mileage']);
    TextEditingController batteryController =
    TextEditingController(text: scooter?['battery']);
    TextEditingController createdDateController =
    TextEditingController(text: scooter?['createdDate']);
    String status = scooter?['status'] ?? 'Active';

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        scooter == null ? 'Add New Scooter' : 'Edit Scooter',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Name', nameController, Icons.electric_scooter),
            _buildTextField('QR Code', qrCodeController, Icons.qr_code),
            _buildTextField('Mileage', mileageController, Icons.speed),
            _buildDropdownField('Status', status, (newValue) {
              setState(() => status = newValue!);
            }),
            _buildTextField('Battery', batteryController, Icons.battery_full),
            _buildDatePickerField('Created Date', createdDateController),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            scooter == null ? 'Add' : 'Save',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (nameController.text.isEmpty || qrCodeController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all required fields.')),
              );
              return;
            }
            setState(() {
              if (scooter == null) {
                scooterData.add({
                  'id': scooterData.length + 1,
                  'name': nameController.text,
                  'qrCode': qrCodeController.text,
                  'mileage': mileageController.text,
                  'status': status,
                  'battery': batteryController.text,
                  'createdDate': createdDateController.text,
                });
              } else {
                scooter['name'] = nameController.text;
                scooter['qrCode'] = qrCodeController.text;
                scooter['mileage'] = mileageController.text;
                scooter['status'] = status;
                scooter['battery'] = batteryController.text;
                scooter['createdDate'] = createdDateController.text;
              }

              filteredData = List.from(scooterData);
            });
            Map<String, dynamic> newScooter = {
              'name': nameController.text,
              'qrCode': qrCodeController.text,
              'mileage': mileageController.text,
              'status': status,
              'battery': batteryController.text,
              'createdDate': createdDateController.text,
            };

            if (scooter == null) {
              // If it's a new scooter, add it
              await FirebaseFirestore.instance
                  .collection('scooters')
                  .doc(nameController.text.toString())
                  .set({
                'name': nameController.text,
                'qrCode': qrCodeController.text,
                'mileage': mileageController.text,
                'status': status,
                'battery': batteryController.text,
                'createdDate': createdDateController.text,
                'isActive': true
              }, SetOptions(merge: true));

              ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Scooter added successfully!')),
                    );
             // await saveScooterToFirebase(newScooter);
            } else {
              // If editing, update the existing scooter by ID
              await _updateScooter(scooter['name'], newScooter);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }


  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),  // Set label text color to green
          prefixIcon: Icon(icon, color: Colors.black),  // Set icon color to green
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green),  // Set border color to green
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 2),  // Set focused border color to green
          ),
        ),
        cursorColor: Colors.green,  // Set cursor color to green
        style: TextStyle(color: Colors.black),  // Set text color to green
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: ['Active', 'Inactive', 'Maintenance'].map((String status) {
          return DropdownMenuItem<String>(
            value: status,
            child: Text(status),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(Icons.info_outline),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.text = pickedDate.toIso8601String().substring(0, 10);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Scooter Management', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: _filterScooters,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green), // Green border when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 2), // Green border when focused
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _addScooter,
                  child: Row(
                    children: [
                      Icon(Icons.add,color: Colors.white,),
                      SizedBox(width: .01),
                      SizedBox(height: 50),
                     // Text('Add Scooter',style: TextStyle(color: Colors.white)),

                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  // headingRowColor: MaterialStateProperty.all(Colors.green), // Set header row background color

                  headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  columns: [
                    DataColumn(label: Center(child: Text('ID'))),
                    DataColumn(label: Center(child: Text('Name'))),
                    DataColumn(label: Center(child: Text('QR Code'))),
                    DataColumn(label: Center(child: Text('Mileage'))),
                    DataColumn(label: Center(child: Text('Status'))),
                    DataColumn(label: Center(child: Text('Battery'))),
                    DataColumn(label: Center(child: Text('Created Date'))),
                    DataColumn(label: Center(child: Text(' Actions'))),
                  ],
                  rows: filteredData.isNotEmpty
                      ? filteredData.map((scooter) {
                    return DataRow(
                      color: WidgetStateColor.resolveWith((states) {
                        return states.contains(WidgetState.hovered)
                            ? Colors.grey[200]!
                            : Colors.white;
                      }),
                      cells: [
                        DataCell(Center(child: Text(scooter['id'].toString()))),
                        DataCell(Center(child: Text(scooter['name']))),
                        DataCell(Center(child: Text(scooter['qrCode']))),
                        DataCell(Center(child: Text(scooter['mileage']))),
                        DataCell(Center(child: Text(scooter['status']))),
                        DataCell(Center(child: Text(scooter['battery']))),
                        DataCell(Center(child: Text(scooter['createdDate']))),
                        DataCell(Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tooltip(
                                message: 'Edit',
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editScooter(scooter),
                                ),
                              ),
                              Tooltip(
                                message: 'Delete',
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: ()
                                  {
                                      _deleteScooter(scooter['name'].toString());
                                  //  _deleteScooter(id);
                                    setState(() {
                                      scooterData.removeWhere(
                                              (item) => item['name'] == scooter['name']);
                                      filteredData = List.from(scooterData);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    );
                  }).toList()
                      : [
                    DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: Text(
                              'No scooters available',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, color: Colors.grey),
                            ),
                          ),
                        ),
                        for (int i = 0; i < 7; i++) DataCell(Center(child: Text(''))),
                      ],
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
