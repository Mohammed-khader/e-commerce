import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/features/cart/widget/cart_icon.dart';
import 'package:first_project/features/home/model/category_model.dart';
import 'package:first_project/features/home/view_model/home_cubit.dart';
import 'package:first_project/features/home/view_model/home_states.dart';
import 'package:first_project/features/home/widget/home_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
part '../widget/home_circle_avatar.dart';
part '../widget/empty_products_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCategory(),
      child: Scaffold(
        drawer: const Drawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            CartIconButton(
              itemCount: 0,
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Home',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        body: Padding(
          padding: AppPadding.allpadding,
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: AppColors.primary,
                  onRefresh: () async {
                    await context.read<HomeCubit>().getCategory();
                  },
                  child: Column(
                    children: [
                      _HomeCircleAvatar(
                        categories: context.read<HomeCubit>().categoriesModel,
                      ),
                      const SizedBox(height: 20),
                      if (state is! HomeLoadingState &&
                          state is! HomeLoadingProductsState &&
                          state is! HomeErrorState &&
                          state is! HomeErrorProductsState)
                        context.read<HomeCubit>().productModel.isEmpty
                            ? const _EmptyProductsWidget()
                            : const HomeGridView()
                      else
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
