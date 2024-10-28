// To parse this JSON data, do
//
//     final postCreateRes = postCreateResFromJson(jsonString);

import 'dart:convert';

PostCreateRes postCreateResFromJson(String str) => PostCreateRes.fromJson(json.decode(str));

String postCreateResToJson(PostCreateRes data) => json.encode(data.toJson());

class PostCreateRes {
  String title;
  String body;
  int userId;
  int id;

  PostCreateRes({
    required this.title,
    required this.body,
    required this.userId,
    required this.id,
  });

  factory PostCreateRes.fromJson(Map<String, dynamic> json) => PostCreateRes(
    title: json["title"],
    body: json["body"],
    userId: json["userId"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "userId": userId,
    "id": id,
  };
}
