class CommandProtocol {
  String createCommand(String action, String data) => '$action:$data';
}
