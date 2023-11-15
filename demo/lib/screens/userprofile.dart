import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // Dummy user data
  final String userName = "John Doe";
  final String userEmail = "john.doe@example.com";
  final String assignedTeacher = "Math - Mrs. Smith"; // Add the assigned teacher here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the edit profile page
              // You can implement the edit functionality here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                userName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                "Assigned Teacher:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                assignedTeacher,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              // Add controller to manage text input
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              // Add controller to manage text input
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Assigned Teacher"),
              // Add controller to manage text input
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality here
                Navigator.pop(context); // Go back to the profile page after saving
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
