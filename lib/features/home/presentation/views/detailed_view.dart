import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/utils/colors/colors.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

import '../../../../core/utils/shared_widgets/app_bar_widget.dart';
import '../../data/models/ArticleModel.dart';

class DetailedView extends StatefulWidget {
  final Article article;

  const DetailedView({Key? key, required this.article}) : super(key: key);

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
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
      width: double.infinity,
      height: 200,
      color: AppColors.backgroundimagefallback,
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 48, color: AppColors.grey),
      ),
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

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final imageUrl = article.urlToImage;
    final author =
        article.author.isNotEmpty ? article.author : article.source.name;

    return Scaffold(
      backgroundColor: context.appbackground,
      appBar: AppBarWidget(
        isDetailedView: true,
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      imageUrl.isNotEmpty
                          ? Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _imageFallback();
                            },
                          )
                          : _imageFallback(),
                ),
              ),
            ),

            const SizedBox(height: 13),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article Title
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: context.textt,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      _safeSvg('assets/pin.svg', width: 12, height: 12),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          author,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTimeAgo(article.publishedAt),
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  if (article.description.isNotEmpty) ...[
                    Text(
                      article.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Roboto",
                        color: context.textt,
                        height: 1.5,
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundimagefallback,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'No description available for this article.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
