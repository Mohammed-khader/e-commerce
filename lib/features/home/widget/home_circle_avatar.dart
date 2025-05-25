import 'package:first_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCircleAvatar extends StatelessWidget {
  const HomeCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFrind = [
      'All',
      'Joker',
      'zabor',
      'Naser',
      'Hamzeh',
      'monther',
      'zabor',
      'torky',
      'somar',
      '3beed',
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: nameFrind.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.5),
            child: Center(
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 40,
                child: Text(
                  nameFrind[index],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
