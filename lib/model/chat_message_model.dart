class ChatMessageModel {
  final String messageContent;
  final String messageType;

  ChatMessageModel({required this.messageContent, required this.messageType});

  factory ChatMessageModel.fromJSON(Map<String, dynamic> json) =>
      ChatMessageModel(
          messageContent: json['messageContent'],
          messageType: json['messageType']);

  Map<String, dynamic> toJson() =>
      {"messageContent": messageContent, "messageType": messageType};
}
