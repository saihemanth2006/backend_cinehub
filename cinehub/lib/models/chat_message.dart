enum MessageType { text, image, emoji }

class ChatMessage {
  final String id;
  final String text;
  final bool isSent;
  final DateTime time;
  bool isRead;
  final MessageType type;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isSent,
    required this.time,
    this.isRead = false,
    this.type = MessageType.text,
  });
}
