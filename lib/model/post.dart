// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:do_nasi/model/user.dart';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    Post({
        required this.user,
        required this.title,
        required this.body,
        required this.date,
    });

    User user;
    String title;
    String body;
    String date;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        user: User.fromJson(json["user"]),
        title: json["title"],
        body: json["body"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "title": title,
        "body": body,
        "date": date,
    };
}
