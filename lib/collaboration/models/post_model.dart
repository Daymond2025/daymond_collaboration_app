import 'dart:convert';

class PostModel {
  final int? id;
  final String? title;
  final String? description;
  final dynamic url;
  final int? views;
  final String? picturePath;
  final int? commentsCount;
  final int? likesCount;
  final int? liked;
  final List<Comment>? comments;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.url,
    this.views,
    this.picturePath,
    this.commentsCount,
    this.likesCount,
    this.liked,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory PostModel.fromRawJson(String str) => PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    views: json["views"],
    picturePath: json["picture_path"],
    commentsCount: json["comments_count"],
    likesCount: json["likes_count"],
    liked: json["liked"],
    comments:json["comments"]==null?[]:  List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    createdAtFr: json["created_at_fr"],
    updatedAtFr: json["updated_at_fr"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "url": url,
    "views": views,
    "picture_path": picturePath,
    "comments_count": commentsCount,
    "likes_count": likesCount,
    "liked": liked,
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
    "created_at": createdAt,
    "updated_at": updatedAt,
    "created_at_fr": createdAtFr,
    "updated_at_fr": updatedAtFr,
  };
}



class Comment {
  final int? id;
  final String? fullName;
  final dynamic pictureUrl;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Comment({
    this.id,
    this.fullName,
    this.pictureUrl,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json['id'],
    fullName: json["full_name"],
    pictureUrl: json["picture_url"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAtFr: json["created_at_fr"],
    updatedAtFr: json["updated_at_fr"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "picture_url": pictureUrl,
    "comment": comment,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "created_at_fr": createdAtFr,
    "updated_at_fr": updatedAtFr,
  };
}
