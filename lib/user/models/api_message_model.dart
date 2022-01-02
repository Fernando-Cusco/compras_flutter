import 'dart:convert';

class Message {
  Message({
    required this.message,
    required this.code,
    required this.status,
  });

  final String message;
  final int code;
  final bool status;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "code": code,
        "status": status,
      };
}
