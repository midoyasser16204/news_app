import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/utils/colors/colors.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isDetailedView;
  final VoidCallback? onBackPressed;

  const AppBarWidget({
    super.key,
    this.isDetailedView = false,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.appbackground;
    final iconColor = context.icon;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isDetailedView
            ? IconButton(
          icon: SvgPicture.asset(
            'assets/back_arrow.svg',
            width: 15,
            height: 25,
            color: iconColor,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
          padding: EdgeInsets.zero,
        )
            : Icon(Icons.grid_view, color: iconColor, size: 35),
      ),
      title: const Text(
        'NEWS',
        style: TextStyle(
          color: AppColors.red,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          fontSize: 17,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.notifications, color: iconColor, size: 35),
            onPressed: () {
              // TODO: Add notification action
            },
          ),
        ),
      ],
    );
  }
}