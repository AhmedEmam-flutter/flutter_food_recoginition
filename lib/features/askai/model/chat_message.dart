enum ChatRole { user, assistant }

class ChatMessage {
  final ChatRole role;
  final String text;
  final DateTime at;

  ChatMessage({
    required this.role,
    required this.text,
    DateTime? at,
  }) : at = at ?? DateTime.now();
}
