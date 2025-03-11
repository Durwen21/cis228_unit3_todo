import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];

  void _addTask() async {
    final newTask = await Navigator.pushNamed(context, '/addTask');

    if (newTask != null) {
      setState(() {
        tasks.add({'task': newTask as Map<String, String>, 'done': false});
      });
    }
  }

  void _editTask(int index) async {
    final editedTask = await Navigator.pushNamed(context, '/addTask', arguments: tasks[index]['task']);

    if (editedTask != null) {
      setState(() {
        tasks[index]['task'] = editedTask as Map<String, String>;
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks yet, add a new task!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = tasks.removeAt(oldIndex);
                          tasks.insert(newIndex, item);
                        });
                      },
                      children: [
                        for (int index = 0; index < tasks.length; index++)
                          Card(
                            key: ValueKey(tasks[index]),
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: ListTile(
                              leading: Icon(Icons.task, color: Colors.teal),
                              title: Text(
                                tasks[index]['task']['name']!,
                                style: TextStyle(
                                  decoration: tasks[index]['done'] ? TextDecoration.lineThrough : null,
                                  color: tasks[index]['done'] ? Colors.grey : null,
                                ),
                              ),
                              subtitle: Text(tasks[index]['task']['category']!),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      tasks[index]['done'] ? Icons.check_box : Icons.check_box_outline_blank,
                                      color: Colors.teal,
                                    ),
                                    onPressed: () => _toggleDone(index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => _editTask(index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteTask(index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Habits',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // Add habit enumeration here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
