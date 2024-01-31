import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_search/models/article.dart';

class ArticleContainer extends StatelessWidget {
  // コンストラクタ
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(
          // 余白の指定
          horizontal: 20,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          // 背景色の指定
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(
            // 角丸を設定
            Radius.circular(32),
          ),
        ),
            // 投稿日
            Text(
              DateFormat("yyyy/MM/dd").format(article.createdAt),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            // タイトル
            Text(
              article.title,
              maxLines: 2, // 行数制限
              overflow: TextOverflow.ellipsis, // 表示範囲超えた時の表示方法の設定
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // タグ
            Text(
              '#${article.tags.join(' #')}', // ←文字列の配列をjoinで結合
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontStyle: FontStyle.italic, // フォントスタイルを斜体に設定
              ),
            ),
            // ハートアイコンといいね数
            Column(
              children: [
                const Icon(
                  Icons.favorite, // ハートアイコン
                  color: Colors.white,
                ),
                Text(
                  article.likesCount.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // 投稿者のアイコンと名前
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(article.user.profileImageUrl),
                ),
                const SizedBox(height: 4),
                Text(
                  article.user.id,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
