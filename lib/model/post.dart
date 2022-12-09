// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.pk,
    required this.user_username,
    required this.user_name,
    required this.user_role,
    required this.title,
    required this.body,
    required this.date,
  });

  int pk;
  String user_username;
  String user_name;
  String user_role;
  String title;
  String body;
  String date;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    pk            : json["pk"],
    user_username : json["fields"]["user"]["username"],
    user_name     : json["fields"]["user"]["name"],
    user_role     : json["fields"]["user"]["role"],
    title         : json["fields"]["title"],
    body          : json["fields"]["body"],
    date          : json["fields"]["date"],
  );

  Map<String, dynamic> toJson() => {
    "pk"           : pk,
    "user_username": user_username,
    "user_name"    : user_name,
    "user_role"    : user_role,
    "title"        : title,
    "body"         : body,
    "date"         : date,
  };
}
