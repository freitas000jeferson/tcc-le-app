import 'package:tcc_le_app/core/domain/message_metadata_dto_response.dart';

class Button {
  final int id;
  final String title;
  final String? payload;

  Button({required this.id, required this.title, this.payload});

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      id: json['id'],
      title: json['title'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'payload': payload};
  }
}

class MessageDtoResponse {
  final dynamic id;
  final dynamic objectId;
  final dynamic userId; // Use appropriate type for User or String
  final String from;
  final String to;
  final String? textBody;
  final String? imageBody;
  final Metadata? metadata;
  final List<Button>? buttonsBody;
  final DateTime? date;
  final DateTime? userDate;

  MessageDtoResponse({
    this.id,
    this.objectId,
    required this.userId,
    required this.from,
    required this.to,
    this.textBody,
    this.imageBody,
    this.metadata,
    this.buttonsBody,
    this.date,
    this.userDate,
  });

  factory MessageDtoResponse.fromJson(Map<String, dynamic> json) {
    return MessageDtoResponse(
      id: json['id'],
      objectId: json['id'],
      userId: json['userId'],
      from: json['from'],
      to: json['to'],
      textBody: json['textBody'],
      imageBody: json['imageBody'],
      metadata:
          json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
      buttonsBody:
          json['buttonsBody'] != null
              ? (json['buttonsBody'] as List)
                  .map((e) => Button.fromJson(e))
                  .toList()
              : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      userDate:
          json['userDate'] != null ? DateTime.parse(json['userDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "objectId": objectId,
      'userId': userId,
      'from': from,
      'to': to,
      'textBody': textBody,
      'imageBody': imageBody,
      'metadata': metadata?.toJson(),
      'buttonsBody': buttonsBody?.map((e) => e.toJson()).toList(),
      'date': date?.toIso8601String(),
      'userDate': userDate?.toIso8601String(),
    };
  }
}
