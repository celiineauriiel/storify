import 'package:flutter/material.dart';

class UpdateBusinessPage extends StatefulWidget {
  @override
  _UpdateBusinessPageState createState() => _UpdateBusinessPageState();
}

class _UpdateBusinessPageState extends State<UpdateBusinessPage> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _selectedCountry = 'United States';

  final List<Map<String, dynamic>> countries = [
    {'name': 'United States', 'iconColor': Colors.blue},
    {'name': 'Indonesia', 'iconColor': Colors.red},
    {'name': 'United Kingdom', 'iconColor': Colors.indigo},
    {'name': 'Australia', 'iconColor': Colors.green},
    {'name': 'India', 'iconColor': Colors.orange},
    {'name': 'Japan', 'iconColor': Colors.red},
    {'name': 'Germany', 'iconColor': Colors.black},
  ];

  void _showUpdateSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Business updated successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _updateBusiness() {
    _showUpdateSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Business'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    // Add your image picker logic here
                  },
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Business Name'),
                      TextField(
                        controller: _businessNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter business name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Country'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCountry,
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value!;
                  });
                },
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['name'] as String,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: country['iconColor'] as Color),
                        const SizedBox(width: 8),
                        Text(country['name'] as String),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            Text('Address'),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _updateBusiness,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}