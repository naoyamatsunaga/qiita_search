import 'package:flutter/material.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key});

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
      ),
    );
  }
}
