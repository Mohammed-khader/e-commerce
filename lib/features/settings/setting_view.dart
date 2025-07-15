import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/features/change_password/view/change_password_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title:
              Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            const SizedBox(height: 5),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: Text('Edit profile',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ChangePasswordView()));
              },
              leading: const Icon(
                Icons.lock_outline,
                size: 30,
              ),
              title: Text('Change password',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
