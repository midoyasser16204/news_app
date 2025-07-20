import 'package:flutter/material.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

import '../../../../core/utils/colors/colors.dart';
import '../../data/models/ArticleModel.dart';
import 'build_news_item_widget.dart';

class NewsListWidget extends StatelessWidget {
  final List<Article> articles;
  final String selectedCategory;

  const NewsListWidget({
    super.key,
    required this.articles,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appbackground,
      child:
          articles.isEmpty
              ? const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    'No articles available',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              )
              : Column(
                children:
                    articles
                        .map(
                          (article) => NewsItemWidget(
                            article: article,
                            category: selectedCategory,
                          ),
                        )
                        .toList(),
              ),
    );
  }
}
