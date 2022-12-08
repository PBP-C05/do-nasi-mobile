import 'dart:convert';

List<HarapanModel> myWatchlistFromJson(String str) => List<HarapanModel>.from(json.decode(str).map((x) => HarapanModel.fromJson(x)));

String myWatchlistToJson(List<HarapanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HarapanModel {
  final int user;
  final String username;
  final String email;
  final String createdAt;
  final String text;

  HarapanModel({
    required this.user,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.text,
  });

   factory HarapanModel.fromJson(Map<String, dynamic> json) => HarapanModel(
        user: json["user"],
        username: json["username"],
        email: json["email"],
        createdAt: json["created_at"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "email": email,
        "created_at": createdAt,
        "text": text,
    };
}