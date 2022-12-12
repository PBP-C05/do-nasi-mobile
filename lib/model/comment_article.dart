import 'dart:convert';

List<Comments> commentsFromJson(String str) =>
    List<Comments>.from(json.decode(str).map((x) => Comments.fromJson(x)));

String commentsToJson(List<Comments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comments {
  Comments({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
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
    required this.name,
    required this.post,
    required this.dateAdded,
    required this.body,
  });

  Name name;
  Post post;
  DateTime dateAdded;
  String body;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: Name.fromJson(json["name"]),
        post: Post.fromJson(json["post"]),
        dateAdded: DateTime.parse(json["date_added"]),
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "post": post.toJson(),
        "date_added": dateAdded.toIso8601String(),
        "body": body,
      };
}

class Name {
  Name({
    required this.username,
    required this.name,
    required this.role,
  });

  String username;
  String name;
  String role;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
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

class Post {
  Post({
    required this.pk,
  });

  int pk;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        pk: json["pk"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
      };
}
