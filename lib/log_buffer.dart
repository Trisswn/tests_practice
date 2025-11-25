class LogBuffer {
  final List<String> _logs = [];

  void add(String log) {
    _logs.add(log);
    if (_logs.length > 5) _logs.removeAt(0);
  }

  List<String> getLogs() => List.unmodifiable(_logs);
}
