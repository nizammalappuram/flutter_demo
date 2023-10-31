import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static const String id = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome, Student Name!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your Progress',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    // Add charts, progress bars, or other widgets to display the user's progress
                    // Example: Circular progress indicator
                    Center(
                      child: CircularProgressIndicator(
                        value: 0.6, // Replace this value with the user's actual progress
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your Courses',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    // Add a list of courses the user is enrolled in
                    ListTile(
                      title: Text('Course 1'),
                      subtitle: Text('Instructor: Instructor Name'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // Navigate to the course details or content
                      },
                    ),
                    ListTile(
                      title: Text('Course 2'),
                      subtitle: Text('Instructor: Instructor Name'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // Navigate to the course details or content
                      },
                    ),
                    // Add more ListTile widgets for additional courses
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
