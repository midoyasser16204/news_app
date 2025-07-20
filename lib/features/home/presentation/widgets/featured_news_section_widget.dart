import 'package:flutter/material.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../data/models/ArticleModel.dart';
import 'latest_news_card_widget.dart';

class FeaturedNewsSection extends StatelessWidget {
  final List<Article> featuredArticles;

  const FeaturedNewsSection({super.key, required this.featuredArticles});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appbackground,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest News',
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child:
                featuredArticles.isEmpty
                    ? const Center(
                      child: Text(
                        'No featured articles available',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredArticles.length,
                      itemBuilder: (context, index) {
                        return FeaturedCardWidget(
                          article: featuredArticles[index],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
