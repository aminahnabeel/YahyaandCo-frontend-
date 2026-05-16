import 'package:flutter/material.dart';

import '../../auth/screens/login_screen.dart';
import '../data/splash_data.dart';
import '../widgets/splash_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: SplashData.pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return SplashPage(
            model: SplashData.pages[index],
            pageIndex: _currentIndex,
            pageCount: SplashData.pages.length,
            onBack: index == 0 ? () {} : () => _goToPage(index - 1),
            onNext: index == SplashData.pages.length - 1
                ? () => _goToPage(index)
                : () => _goToPage(index + 1),
            onGetStarted: _goToLogin,
          );
        },
      ),
    );
  }
}
