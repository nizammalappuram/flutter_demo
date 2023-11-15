import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

void main() {
  runApp(TaskManagementScreen());
}

class Task {
  final String title;
  final String description;
  final DateTime dateTime;

  Task(this.title, this.description, this.dateTime);
}

class TaskManagementScreen extends StatelessWidget {
  final List<Task> adminTasks = [
    Task("Teacher Instructions", "Instructions by the following Teacher.",
        DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38.0,
                color: Colors.teal,
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
            AdminDescription(adminTasks),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "User Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: UserTaskList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDescription extends StatelessWidget {
  final List<Task> adminTasks;

  AdminDescription(this.adminTasks);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: adminTasks.map((task) {
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(task.description),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class UserTaskList extends StatefulWidget {
  @override
  _UserTaskListState createState() => _UserTaskListState();
}

class _UserTaskListState extends State<UserTaskList> {
  final List<Task> userTasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: userTasks.length,
            itemBuilder: (context, index) {
              final task = userTasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description),
                    Text(
                      "Date: ${DateFormat('dd/MM/y').format(task.dateTime)}", // Format the date
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    Text(
                      "Time: ${DateFormat('HH:mm').format(task.dateTime)}", // Format the time
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteUserTask(index),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _taskController,
            decoration: InputDecoration(labelText: "What did you do today?"),
            onSubmitted: (_) => _addUserTask(),
          ),
        ),
      ],
    );
  }

  void _addUserTask() {
    final userTask = _taskController.text;
    if (userTask.isNotEmpty) {
      final now = DateTime.now();
      setState(() {
        userTasks.add(Task("User Task", userTask, now));
        _taskController.clear();
      });
    }
  }

  void _deleteUserTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                setState(() {
                  userTasks.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
