import 'dart:io';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../storage/article_storage.dart';
import 'article_detail_screen.dart';
import 'article_form_screen.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  List<ArticleModel> articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final loaded = await ArticleStorage.loadArticles();
    if (loaded.isEmpty) {
      articles = [];
    } else {
      articles = loaded;
    }
    setState(() {});
  }

  Future<void> _openForm({ArticleModel? article, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArticleFormScreen(article: article, index: index),
      ),
    );
    if (result == true) _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          'Daftar Artikel',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: File(article.imagePath).existsSync()
                  ? Image.file(File(article.imagePath), width: 80, fit: BoxFit.cover)
                  : const Icon(Icons.broken_image),
              title: Text(article.title),
              subtitle: Text(article.subtitle),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _openForm(article: article, index: index),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailScreen(article: article),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
