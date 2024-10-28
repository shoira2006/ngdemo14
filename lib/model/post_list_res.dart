// To parse this JSON data, do
//
//     final postListRes = postListResFromJson(jsonString);

import 'dart:convert';

List<PostListRes> postListResFromJson(String str) => List<PostListRes>.from(json.decode(str).map((x) => PostListRes.fromJson(x)));

String postListResToJson(List<PostListRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostListRes {
  int userId;
  int id;
  String title;
  String body;

  PostListRes({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostListRes.fromJson(Map<String, dynamic> json) => PostListRes(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
