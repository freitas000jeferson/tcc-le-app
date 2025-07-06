class Button {
  final int id;
  final String title;
  final String payload;

  const Button({required this.id, required this.title, required this.payload});

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "payload": payload,
  };
  factory Button.fromJson(Map<String, dynamic> json) => Button(
    id: json["id"] as int,
    title: json["title"] as String,
    payload: json["payload"] as String,
  );
}
