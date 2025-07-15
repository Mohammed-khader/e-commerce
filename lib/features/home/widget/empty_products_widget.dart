part of '../view/home_view.dart';

class _EmptyProductsWidget extends StatelessWidget {
  const _EmptyProductsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary,
          ),
        ),
        child: Center(
          child: Text(
            'No products found',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
