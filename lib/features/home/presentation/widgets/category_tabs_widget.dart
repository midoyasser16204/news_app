import 'package:flutter/material.dart';
import 'package:news_app/core/utils/colors/colors.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

class CategoryTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const CategoryTabs({
    super.key,
    required this.tabs,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appbackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                final isSelected = selectedTabIndex == index;

                return GestureDetector(
                  onTap: () => onTabSelected(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.orange : AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color:
                            isSelected
                                ? AppColors.white
                                : context.nonselecedtext,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
