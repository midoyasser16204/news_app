import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/utils/colors/colors.dart';

import '../../data/models/ArticleModel.dart';
import '../views/detailed_view.dart';

class FeaturedCardWidget extends StatefulWidget {
  final Article article;

  const FeaturedCardWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<FeaturedCardWidget> createState() => _FeaturedCardWidgetState();
}

class _FeaturedCardWidgetState extends State<FeaturedCardWidget> {
  String _formatTimeAgo(DateTime publishedAt) {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  void _navigateToDetailedView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedView(article: widget.article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return InkWell(
      onTap: () => _navigateToDetailedView(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 247,
        height: 172,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 116.47541046142578,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child:
                    article.urlToImage.isNotEmpty
                        ? Image.network(
                          article.urlToImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.backgroundimagefallback,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                  color: AppColors.grey,
                                ),
                              ),
                            );
                          },
                        )
                        : Container(
                          color: AppColors.backgroundimagefallback,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 48,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
              ),
            ),

            const SizedBox(height: 5),

            SizedBox(
              height: 76,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset('assets/pin.svg', width: 8, height: 8),
                        const SizedBox(width: 1),
                        Expanded(
                          child: Text(
                            article.author.isNotEmpty
                                ? article.author
                                : article.source.name,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTimeAgo(article.publishedAt),
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
