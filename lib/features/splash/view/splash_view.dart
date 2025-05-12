import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_images.dart';
import 'package:first_project/features/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _goToLogin();
    super.initState();
  }

  void _goToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const LoginView();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Lottie.asset(AppImages.splashLogo)),
    );
  }
}
