import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';

class ArticleStorage {
  static const String _key = 'articles';

  static Future<void> saveArticles(List<ArticleModel> articles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, ArticleModel.toJsonList(articles));
  }

  static Future<List<ArticleModel>> loadArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      return ArticleModel.fromJsonList(jsonString);
    }
    return [];
  }
}
