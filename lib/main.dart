import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Demo',
      theme: ThemeData.dark(), // Using dark theme
      home: InteractiveDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InteractiveDemo extends StatefulWidget {
  InteractiveDemo({super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  int _count = 0;
  bool _showWidget = false;

  // ✅ Using Map for task list
  final Map<String, Map<String, dynamic>> _tasks = {
    "task1": {"name": "Buy groceries", "done": false},
    "task2": {"name": "Finish report", "done": false},
    "task3": {"name": "Call mom", "done": false},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Interactive Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Counter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Tap the button to increment the counter."),
            SizedBox(height: 12),
            Text("Count: $_count", style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade200,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text("Increment"),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Toggle Visibility",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Toggle the visibility of the widget below."),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Show Widget"),
                Switch(
                  value: _showWidget,
                  onChanged: (val) {
                    setState(() {
                      _showWidget = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            if (_showWidget)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/mountains.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 24),
            Text(
              "Task List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Mark tasks as completed by checking the boxes."),
            SizedBox(height: 12),

            ..._tasks.entries.map((entry) {
              String taskKey = entry.key;
              String taskName = entry.value["name"];
              bool isDone = entry.value["done"];

              return CheckboxListTile(
                value: isDone,
                onChanged: (val) {
                  setState(() {
                    _tasks[taskKey]!["done"] = val!;
                  });
                },
                title: Text(
                  "$taskKey: $taskName",
                  style: TextStyle(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.greenAccent,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
