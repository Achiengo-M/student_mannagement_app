class EventLogger {
  // Stores all logged events
  final List<String> _logs = [];

  // Adds a new event to the log
  void addEvent(String event) {
    _logs.insert(0, event);
  }

  // Returns all logged events
  List<String> getLogs() {
    return _logs;
  }

  // Returns the latest event
  String getLatestEvent() {
    if (_logs.isEmpty) {
      return "No interaction yet.";
    }
    return _logs.first;
  }

  // Clears all logged events
  void clearLogs() {
    _logs.clear();
  }
}