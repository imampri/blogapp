import 'dart:io';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          article.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              File(article.imagePath).existsSync()
                  ? Image.file(File(article.imagePath))
                  : const Icon(Icons.broken_image, size: 200),
              const SizedBox(height: 16),
              Text(article.title, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(article.subtitle, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text(article.content, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
