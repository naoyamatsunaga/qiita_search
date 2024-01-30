import 'package:qiita_search/models/user.dart';

class Article {
  // コンストラクタ
  Article({
    required this.title,
    required this.user,
    this.likesCount = 0,
    this.tags = const [],
    required this.createdAt,
    required this.url,
  });

  // プロパティ
  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  late final DateTime createdAt;
  final String url;

// JSONからArticleを生成するファクトリ
  factory Article.fromJson(dynamic json) {
    return Article(
      title: json['title'] as String,
      user: User.fromJson(['user']),
      url: json['url'] as String,
      createdAt: DateTime.parse(json['cteated_at'] as String),
      likesCount: json['likes_count'] as int,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),
    );
  }
}
