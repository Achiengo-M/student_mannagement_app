import 'package:flutter/material.dart';
import '../services/event_logger.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final TextEditingController _controller = TextEditingController();

  final EventLogger logger = EventLogger();

  String _message = "No interaction yet.";

  // Method to log events
  void _addLog(String event) {
    setState(() {
      logger.addEvent(event);
      _message = logger.getLatestEvent();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Handling"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Keyboard Input
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.keyboard),
              ),
              onChanged: (value) {
                _addLog("Keyboard Input: $value");
              },
            ),

            const SizedBox(height: 20),

            // Touch Gestures
            GestureDetector(
              onTap: () {
                _addLog("Single Tap Detected");
              },
              onDoubleTap: () {
                _addLog("Double Tap Detected");
              },
              onLongPress: () {
                _addLog("Long Press Detected");
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "Touch Here",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Current Message
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Event Log",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: logger.getLogs().length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.event,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        logger.getLogs()[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}