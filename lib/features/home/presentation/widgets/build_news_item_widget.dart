import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/utils/colors/colors.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

import '../../data/models/ArticleModel.dart';
import '../views/detailed_view.dart';

class NewsItemWidget extends StatefulWidget {
  final Article article;
  final String category;

  const NewsItemWidget({
    Key? key,
    required this.article,
    required this.category,
  }) : super(key: key);

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget> {
  String _formatTimeAgo(DateTime? publishedAt) {
    if (publishedAt == null) return 'Unknown';
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

  Widget _imageFallback() {
    return Container(
      width: 95,
      height: 105,
      color: AppColors.backgroundimagefallback,
      child: const Icon(Icons.image_not_supported, color: AppColors.grey),
    );
  }

  Widget _safeSvg(
    String asset, {
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      placeholderBuilder: (_) => const SizedBox(),
      fit: BoxFit.scaleDown,
    );
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
    final imageUrl = article.urlToImage;
    final author =
        article.author.isNotEmpty ? article.author : article.source.name;
    const Map<String, String> categoryIcons = {
      'Science': 'assets/science-svgrepo-com.svg',
      'Health': 'assets/health-svgrepo-com.svg',
      'Entertainment': 'assets/entertainment-svgrepo-com.svg',
      'Business': 'assets/business-svgrepo-com.svg',
      'Sports': 'assets/sports-mode-svgrepo-com.svg',
      'Technology': 'assets/rocket-svgrepo-com.svg',
    };

    return InkWell(
      onTap: () => _navigateToDetailedView(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  imageUrl.isNotEmpty
                      ? Image.network(
                        imageUrl,
                        width: 95,
                        height: 105,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _imageFallback();
                        },
                      )
                      : _imageFallback(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.textt,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _safeSvg('assets/pin.svg', width: 8, height: 8),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Text(
                          author,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 23),
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (categoryIcons.containsKey(widget.category)) ...[
                            _safeSvg(
                              categoryIcons[widget.category]!,
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            widget.category,
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        _formatTimeAgo(article.publishedAt),
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
