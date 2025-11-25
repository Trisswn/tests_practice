class CommandProtocol {
  String createCommand(String action, dynamic data) => '$action:$data';
}
