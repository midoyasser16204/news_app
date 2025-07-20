import 'package:dio/dio.dart';

import '../../../features/home/data/models/ArticleModel.dart';

class NewsApiService {
  Future<List<Article>> getArticles({required String category}) async {
    try {
      final params = {
        'country': 'us',
        'apiKey': 'f7b4e0d169184a6abe20dd926a7fd7bc',
      };

      if (category != 'all') {
        params['category'] = category;
      }

      final response = await Dio().get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: params,
      );

      print('Fetched response: ${response.data}');

      List articles = response.data["articles"];
      List<Article> articleModels = [];
      for (var article in articles) {
        articleModels.add(Article.fromJson(article));
      }

      return articleModels;
    }
    catch (e) {
      print("Error fetching articles: $e");
      return [];
    }
  }
}
