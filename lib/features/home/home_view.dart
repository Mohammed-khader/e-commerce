import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/features/home/widget/home_circle_avatar.dart';
import 'package:first_project/features/home/widget/home_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Home',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
      body: Padding(
        padding: AppPadding.allpadding,
        child: const Column(
          children: [
            HomeCircleAvatar(),
            SizedBox(height: 20),
            HomeGridView(),
          ],
        ),
      ),
    );
  }
}
