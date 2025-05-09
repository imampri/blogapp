import 'dart:io';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../models/article_model.dart';
import '../storage/article_storage.dart';

class ArticleFormScreen extends StatefulWidget {
  final ArticleModel? article;
  final int? index;

  const ArticleFormScreen({super.key, this.article, this.index});

  @override
  _ArticleFormScreenState createState() => _ArticleFormScreenState();
}

class _ArticleFormScreenState extends State<ArticleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleCtrl;
  late TextEditingController subtitleCtrl;
  late TextEditingController descCtrl;
  late TextEditingController contentCtrl;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.article?.title ?? '');
    subtitleCtrl = TextEditingController(text: widget.article?.subtitle ?? '');
    descCtrl = TextEditingController(text: widget.article?.description ?? '');
    contentCtrl = TextEditingController(text: widget.article?.content ?? '');
    imagePath = widget.article?.imagePath;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(picked.path);
      final saved = await File(picked.path).copy('${dir.path}/$fileName');
      setState(() {
        imagePath = saved.path;
      });
    }
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newArticle = ArticleModel(
        title: titleCtrl.text,
        subtitle: subtitleCtrl.text,
        description: descCtrl.text,
        imagePath: imagePath!,
        content: contentCtrl.text,
      );

      final articles = await ArticleStorage.loadArticles();
      if (widget.index != null) {
        articles[widget.index!] = newArticle;
      } else {
        articles.add(newArticle);
      }

      await ArticleStorage.saveArticles(articles);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          widget.article == null ? 'Tambah Artikel' : 'Edit Artikel',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: subtitleCtrl,
                decoration: const InputDecoration(labelText: 'Subjudul'),
              ),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Deskripsi Singkat'),
              ),
              const SizedBox(height: 16),
              const Text('Gambar'),
              const SizedBox(height: 8),
              imagePath != null && File(imagePath!).existsSync()
                  ? Image.file(File(imagePath!), height: 150)
                  : Container(height: 150, color: Colors.grey[200], child: const Center(child: Text('Belum ada gambar'))),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar'),
                onPressed: _pickImage,
              ),
              TextFormField(
                controller: contentCtrl,
                decoration: const InputDecoration(labelText: 'Konten Lengkap'),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
