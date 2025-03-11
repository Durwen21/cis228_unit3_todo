import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedCategory = 'Work';

  void _submitTask() {
    final task = _taskController.text;
    if (task.isNotEmpty) {
      Navigator.pop(context, {'name': task, 'category': _selectedCategory});
    }
  }

  void _addPredefinedTask(String task) {
    Navigator.pop(context, {'name': task, 'category': _selectedCategory});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Task Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.task),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Work', 'Personal', 'Health']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitTask,
                icon: Icon(Icons.add),
                label: Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Quick Add',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'cleaningMotorcycle',
                  onPressed: () => _addPredefinedTask('Cleaning Motorcycle'),
                  icon: Icon(Icons.motorcycle),
                  label: Text('Cleaning Motorcycle'),
                  backgroundColor: Colors.teal,
                ),
                FloatingActionButton.extended(
                  heroTag: 'changeOil',
                  onPressed: () => _addPredefinedTask('Change Oil'),
                  icon: Icon(Icons.oil_barrel),
                  label: Text('Change Oil'),
                  backgroundColor: Colors.teal,
                ),
                FloatingActionButton.extended(
                  heroTag: 'changeOilFilter',
                  onPressed: () => _addPredefinedTask('Change Oil Filter'),
                  icon: Icon(Icons.filter_alt),
                  label: Text('Change Oil Filter'),
                  backgroundColor: Colors.teal,
                ),
                FloatingActionButton.extended(
                  heroTag: 'readBook',
                  onPressed: () => _addPredefinedTask('Read a Book'),
                  icon: Icon(Icons.book),
                  label: Text('Read a Book'),
                  backgroundColor: Colors.teal,
                ),
                FloatingActionButton.extended(
                  heroTag: 'cleanRoom',
                  onPressed: () => _addPredefinedTask('Clean the Room'),
                  icon: Icon(Icons.cleaning_services),
                  label: Text('Clean the Room'),
                  backgroundColor: Colors.teal,
                ),
                // Add more predefined tasks here
              ],
            ),
          ],
        ),
      ),
    );
  }
}
