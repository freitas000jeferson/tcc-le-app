enum QuestionStatus { RIGTH, WRONG, TO_DO }

enum QuestionnarieStatus { TO_DO, DOING, DONE }

class Metadata {
  String? id;
  QuestionnarieStatus? status;
  QuestionStatus? lastQuestionStatus;
  int? totalQuestions;
  int? totalCorrectAnswers;
  QuestionResponseDto? question;
  List<String>? text;
  List<String>? images;
  List<String>? examples;

  Metadata({
    this.id,
    this.status,
    this.lastQuestionStatus,
    this.totalQuestions,
    this.totalCorrectAnswers,
    this.question,
    this.text,
    this.images,
    this.examples,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    id: json['id'] as String?,
    status:
        json['status'] != null
            ? QuestionnarieStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['status'],
              orElse: () => QuestionnarieStatus.TO_DO,
            )
            : null,
    lastQuestionStatus:
        json['lastQuestionStatus'] != null
            ? QuestionStatus.values.firstWhere(
              (e) => e.toString().split('.').last == json['lastQuestionStatus'],
              orElse: () => QuestionStatus.TO_DO,
            )
            : null,
    totalQuestions: json['totalQuestions'] as int?,
    totalCorrectAnswers: json['totalCorrectAnswers'] as int?,
    question:
        json['question'] != null
            ? QuestionResponseDto.fromJson(
              json['question'] as Map<String, dynamic>,
            )
            : null,
    text: (json['text'] as List?)?.map((e) => e as String).toList(),
    images: (json['images'] as List?)?.map((e) => e as String).toList(),
    examples: (json['examples'] as List?)?.map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status?.toString().split('.').last,
    'lastQuestionStatus': lastQuestionStatus?.toString().split('.').last,
    'totalQuestions': totalQuestions,
    'totalCorrectAnswers': totalCorrectAnswers,
    'question': question?.toJson(),
    'text': text,
    'images': images,
    'examples': examples,
  };
}

class QuestionResponseDto {
  String? id;
  List<String>? text;
  String? image;
  List<Option>? options;
  QuestionStatus? status;

  QuestionResponseDto({
    this.id,
    this.text,
    this.image,
    this.options,
    this.status,
  });

  factory QuestionResponseDto.fromJson(Map<String, dynamic> json) =>
      QuestionResponseDto(
        id: json['id'] as String?,
        text: (json['text'] as List?)?.map((e) => e as String).toList(),
        image: json['image'] as String?,
        options:
            (json['options'] as List?)
                ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
                .toList(),
        status:
            json['status'] != null
                ? QuestionStatus.values.firstWhere(
                  (e) => e.toString().split('.').last == json['status'],
                  orElse: () => QuestionStatus.TO_DO,
                )
                : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'image': image,
    'options': options?.map((e) => e.toJson()).toList(),
    'status': status?.toString().split('.').last,
  };
}

class Option {
  int? id;
  String? text;

  Option({this.id, this.text});

  factory Option.fromJson(Map<String, dynamic> json) =>
      Option(id: json['id'] as int?, text: json['text'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}
