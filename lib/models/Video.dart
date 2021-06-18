import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

class Video {
  Video({
    this.publishedAt,
    this.channelId,
    this.videoId,
    this.title,
    this.description,
    this.thumbnailUrl,
  });

  DateTime? publishedAt;
  String? channelId;
  String? videoId;
  String? title;
  String? description;
  String? thumbnailUrl;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        publishedAt: DateTime.parse(json["snippet"]["publishedAt"]),
        channelId: json["snippet"]["channelId"],
        videoId: json["id"]["videoId"],
        title: json["snippet"]["title"],
        description: json["snippet"]["description"],
        thumbnailUrl: json["snippet"]["thumbnails"]["medium"]["url"],
      );
}
