import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:qiita_search/models/article.dart';
import 'package:qiita_search/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // 検索結果を格納する変数
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            // 検索ボックス
            child: TextField(
              style: const TextStyle(
                // TextStyleを渡すことでフォントサイズや色を指定できる
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                // 検索処理を実行する
                final results = await searchQiita(value);
                // 検索結果を代入する
                setState(() => articles = results);
              },
            ),
          ),
          // 検索一覧
          Expanded(
            child: ListView(
              children: articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(), // 配列を展開し、Widgetのリストに変換している。
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Article>> searchQiita(String keyword) async {
  // 1.https通信に必要なデータを準備する
  // Uri.https([baseUrl], [Urlパス], Map<String,dynamic>[クエリパラメータ])
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
  });
  // アクセストークンを取得
  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

  // 2.Qiita APIにリクエストを送る
  // アクセストークンを含めてリクエストを送信
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  // 3.戻り値をArticleクラスの配列に変換
  // 4.変換したArticleクラスの配列を返す(returnする)
  if (res.statusCode == 200) {
    // レスポンスをモデルクラスへ変換
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}
