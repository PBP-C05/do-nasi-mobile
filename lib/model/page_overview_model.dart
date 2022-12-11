// To parse this JSON data, do
//
//     final pageOverview = pageOverviewFromJson(jsonString);

import 'dart:convert';

List<PageOverview> pageOverviewFromJson(String str) => List<PageOverview>.from(json.decode(str).map((x) => PageOverview.fromJson(x)));

String pageOverviewToJson(List<PageOverview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PageOverview {
  PageOverview({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory PageOverview.fromJson(Map<String, dynamic> json) => PageOverview(
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
    required this.title,
    required this.deadline,
    required this.description,
    required this.donation,
  });

  int user;
  String title;
  DateTime deadline;
  String description;
  bool donation;


  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    title: json["title"],
    deadline: DateTime.parse(json["deadline"]),
    description: json["description"],
    donation: json["Donation"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "title": title,
    "deadline": "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
    "description": description,
    "Donation": donation,
  };
}

enum Model {
  PAGE_OVERVIEW_DONASI
}

final modelValues = EnumValues({
  "page_overview.donasi": Model.PAGE_OVERVIEW_DONASI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
