import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart'; // Import your API service file

class StudentForm extends StatefulWidget {
  final Function onNext;

  const StudentForm({Key? key, required this.onNext}) : super(key: key);

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String? selectedAcademy;
  final List<Map<String, String>> academyOptions = [
    {'key': 'highschool', 'value': 'highschool', 'text': 'High School'},
    {'key': 'higherschool', 'value': 'higherschool', 'text': 'Higher Secondary School'},
    {'key': 'graduate', 'value': 'graduate', 'text': 'Graduate'},
    {'key': 'postgraduate', 'value': 'postgraduate', 'text': 'Post Graduate'},
    {'key': 'other', 'value': 'other', 'text': 'Other'},
    // Add more academy options as needed
  ];

  void handleDropdownChange(String? value) {
    setState(() {
      selectedAcademy = value;
    });
  }

  void handleSubmit() async {
    String lname = lnameController.text;
    String fname = fnameController.text;
    String city = cityController.text;
    String country = countryController.text;

    if (lname.isNotEmpty &&
        fname.isNotEmpty &&
        city.isNotEmpty &&
        country.isNotEmpty &&
        selectedAcademy != null) {
      Map<String, dynamic>? response = await APIService.submitStudentDetails(
        fname: fname,
        lname: lname,
        city: city,
        country: country,
        selectedAcademy: selectedAcademy,
      );

      if (response != null) {
        // Handle successful response
        print('Form submitted successfully.');
        widget.onNext(); // Proceed to the next step
      } else {
        // Handle failed response or error
        print('Failed to submit form.');
        // You can add error handling or UI updates here
      }
    } else {
      // Handle incomplete form data
      print('Please fill in all fields.');
      // You can display an error message or handle it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Form')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter Your Personal Details',
              style: TextStyle(
                fontFamily: 'Helvetica, Arial, sans-serif',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: fnameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lnameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextFormField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            DropdownButtonFormField<String>(
              value: selectedAcademy,
              hint: Text('Select Academy'),
              onChanged: handleDropdownChange,
              items: academyOptions
                  .map((option) => DropdownMenuItem<String>(
                value: option['value'],
                child: Text(option['text']!),
              ))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: handleSubmit,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}