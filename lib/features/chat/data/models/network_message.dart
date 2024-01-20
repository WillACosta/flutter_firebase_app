class NetworkMessage {
  final String id;
  final String sentBy;
  final String messageText;
  final String? sentAt;

  NetworkMessage({
    required this.id,
    required this.sentBy,
    required this.messageText,
    required this.sentAt,
  });

  factory NetworkMessage.fromMap(Map<String, dynamic> map) {
    return NetworkMessage(
      id: map['id'] ?? '',
      sentBy: map['sentBy'] ?? '',
      messageText: map['messageText'] ?? '',
      sentAt: map['sentAt'],
    );
  }
}
