// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:do_nasi/model/user.dart';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    Comment({
      required this.user_username,
      required this.user_name,
      required this.user_role,
      required this.body,
      required this.date,
    });

    String user_username;
    String user_name;
    String user_role;
    String body;
    String date;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      user_username : json["fields"]["user"]["username"],
      user_name     : json["fields"]["user"]["name"],
      user_role     : json["fields"]["user"]["role"],
      body          : json["fields"]["body"],
      date          : json["fields"]["date"],
    );

    Map<String, dynamic> toJson() => {
      "user_username": user_username,
      "user_name"    : user_name,
      "user_role"    : user_role,
      "body"         : body,
      "date"         : date,
    };
}
