class MessageModel {
  final String id;
  final String sentBy;
  final String messageText;
  final String? sentDate;

  MessageModel({
    required this.id,
    required this.sentBy,
    required this.messageText,
    this.sentDate,
  });
}
