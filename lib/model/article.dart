// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);
import 'dart:convert';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.date,
    required this.title,
    required this.body,
    required this.slug,
  });

  User user;
  DateTime date;
  String title;
  String body;
  String slug;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: User.fromJson(json["user"]),
        date: DateTime.parse(json["date"]),
        title: json["title"],
        body: json["body"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "date": date.toIso8601String(),
        "title": title,
        "body": body,
        "slug": slug,
      };
}

class User {
  User({
    required this.username,
    required this.name,
    required this.role,
  });

  String username;
  String name;
  String role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "role": role,
      };
}
