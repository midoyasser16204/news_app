import 'package:flutter/material.dart';
import 'package:news_app/core/utils/shared_widgets/app_bar_widget.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

import '../../../../core/utils/network/news_api_service.dart';
import '../../data/models/ArticleModel.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/featured_news_section_widget.dart';
import '../widgets/news_list_widget.dart';
import '../widgets/search_bar_widget.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTabIndex = 0;
  final List<String> tabs = [
    'All',
    'Science',
    'Health',
    'Entertainment',
    'Business',
    'Sports',
    'Technology',
  ];
  final List<String> categories = [
    'all',
    'science',
    'health',
    'entertainment',
    'business',
    'sports',
    'technology',
  ];

  List<Article> articles = [];
  List<Article> featuredArticles = [];
  bool isLoading = true;
  String errorMessage = '';

  final NewsApiService _newsApiService = NewsApiService();

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final fetchedArticles = await _newsApiService.getArticles(
        category: categories[selectedTabIndex],
      );

      setState(() {
        articles = fetchedArticles;
        featuredArticles = fetchedArticles.take(2).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load articles: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appbackground,
      appBar: const AppBarWidget(isDetailedView: false),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
      )
          : errorMessage.isNotEmpty
          ? _buildErrorView()
          : RefreshIndicator(
        onRefresh: _loadArticles,
        color: Colors.orange,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SearchBarWidget()),
            SliverToBoxAdapter(
              child: FeaturedNewsSection(
                featuredArticles: featuredArticles,
              ),
            ),
            SliverToBoxAdapter(
              child: CategoryTabs(
                tabs: tabs,
                selectedTabIndex: selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                  _loadArticles();
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return NewsListWidget(
                    articles: articles.skip(2).toList(),
                    selectedCategory: tabs[selectedTabIndex],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadArticles,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
