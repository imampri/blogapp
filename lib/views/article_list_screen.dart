import 'dart:io';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../storage/article_storage.dart';
import 'article_detail_screen.dart';
import 'article_form_screen.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

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

  Future<void> _deleteArticle(int index) async {
    setState(() {
      articles.removeAt(index);
    });

    await ArticleStorage.saveArticles(articles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Daftar Artikel',
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _openForm(article: article, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteDialog(index),
                  ),
                ],
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

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Artikel"),
          content: const Text("Apakah Anda yakin ingin menghapus artikel ini?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteArticle(index); // Hapus artikel
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
}
