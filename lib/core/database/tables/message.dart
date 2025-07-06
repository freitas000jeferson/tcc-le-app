import 'dart:convert';

import 'package:tcc_le_app/core/database/tables/button.dart';
import 'package:tcc_le_app/core/database/utils/type_converter.dart';

class Message {
  int? id;
  String objectId;
  String userId;
  String from;
  String to;
  String textBody;
  String imageBody;
  Map<String, dynamic>? metadata;
  List<Button>? buttonsBody;
  DateTime date;
  DateTime userDate;
  bool isViewer;
  Message({
    this.id,
    required this.objectId,
    required this.userId,
    required this.from,
    required this.to,
    required this.textBody,
    required this.imageBody,
    this.metadata,
    this.buttonsBody,
    required this.date,
    required this.userDate,
    required this.isViewer,
  });

  Map<String, dynamic> toJson() => {
    MessageVarNames.id: id,
    MessageVarNames.objectId: objectId,
    MessageVarNames.userId: userId,
    MessageVarNames.from: from,
    MessageVarNames.to: to,
    MessageVarNames.textBody: textBody,
    MessageVarNames.imageBody: imageBody,
    MessageVarNames.metadata: MetadataConverter.toJson(
      metadata ?? <String, dynamic>{},
    ),
    MessageVarNames.buttonsBody: ButtonBodyConverter.toJson(
      buttonsBody ?? <Button>[],
    ),
    MessageVarNames.date: TypeConverter.dateToJson(date),
    MessageVarNames.userDate: TypeConverter.dateToJson(userDate),
    MessageVarNames.isViewer: TypeConverter.booleanToJson(isViewer),
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json[MessageVarNames.id] as int,
    objectId: json[MessageVarNames.objectId] as String,
    userId: json[MessageVarNames.userId] as String,
    from: json[MessageVarNames.from] as String,
    to: json[MessageVarNames.to] as String,
    textBody: json[MessageVarNames.textBody] as String,
    imageBody: json[MessageVarNames.imageBody] as String,
    metadata: MetadataConverter.fromJson(
      json[MessageVarNames.metadata] ?? '{}',
    ),
    buttonsBody: ButtonBodyConverter.fromJson(
      json[MessageVarNames.buttonsBody] ?? '[]',
    ),
    date: TypeConverter.dateFromJson(json[MessageVarNames.date]),
    userDate: TypeConverter.dateFromJson(json[MessageVarNames.userDate]),
    isViewer: TypeConverter.booleanFromJson(json[MessageVarNames.isViewer]),
  );
}

class ButtonBodyConverter {
  static List<Button> fromJson(String fromDb) {
    return (json.decode(fromDb) as List<dynamic>)
        .map((json) => Button.fromJson(json))
        .toList();
  }

  static String toJson(List<Button> value) {
    return json.encode(value.map((e) => e.toJson()).toList());
  }
}

class MetadataConverter {
  static Map<String, dynamic> fromJson(String fromDb) {
    return Map<String, dynamic>.from(json.decode(fromDb));
  }

  static String toJson(Map<String, dynamic> value) {
    return json.encode(value);
  }
}

class MessageVarNames {
  static const String id = "id";
  static const String objectId = "objectId";
  static const String userId = "userId";
  static const String from = "from";
  static const String to = "to";
  static const String textBody = "textBody";
  static const String imageBody = "imageBody";
  static const String metadata = "metadata";
  static const String buttonsBody = "buttonsBody";
  static const String date = "date";
  static const String userDate = "userDate";
  static const String isViewer = "isViewer";
}
