class SendMessageDto {
  final String? userId;
  final String message;
  final DateTime? userDate;

  SendMessageDto({this.userId, required this.message, this.userDate});

  factory SendMessageDto.fromJson(Map<String, dynamic> json) {
    return SendMessageDto(
      userId: json['userId'] as String?,
      message: json['message'] as String,
      userDate:
          json['userDate'] != null ? DateTime.parse(json['userDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'message': message,
      'userDate': userDate?.toIso8601String(),
    };
  }
}
