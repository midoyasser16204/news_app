import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/utils/themes/light/light_theme.dart';
import 'package:news_app/features/home/presentation/views/home_view.dart';
import '../../../../core/utils/colors/colors.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return HomeView();
        }),
      );});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/news-svgrepo-com.svg',
              color: context.appbackground,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: context.appbackground,
            ),
          ],
        ),
      ),
    );
  }
}
