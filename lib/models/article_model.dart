import 'dart:convert';

class ArticleModel {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final String content;

  ArticleModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'description': description,
    'imagePath': imagePath,
    'content': content,
  };

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    title: json['title'],
    subtitle: json['subtitle'],
    description: json['description'],
    imagePath: json['imagePath'] ?? "",
    content: json['content'],
  );

  static List<ArticleModel> fromJsonList(String jsonString) {
    final List decoded = json.decode(jsonString);
    return decoded.map((item) => ArticleModel.fromJson(item)).toList();
  }

  static String toJsonList(List<ArticleModel> articles) {
    return json.encode(articles.map((a) => a.toJson()).toList());
  }
}
