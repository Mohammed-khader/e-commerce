import 'package:first_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoadingDialog extends StatelessWidget {
  const CustomLoadingDialog({super.key});
  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const CustomLoadingDialog());
   
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Please Wait ...',
              style: TextStyle(
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
