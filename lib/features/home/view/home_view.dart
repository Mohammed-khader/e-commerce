import 'package:first_project/core/local/local_storage_service.dart';
import 'package:first_project/core/local/user_data.dart';
import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/icons/view/cart_icon_view.dart';
import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/core/widgets/text_field/custom_text_field.dart';
import 'package:first_project/features/favourites/view/favourites_view.dart';
import 'package:first_project/features/home/model/category_model.dart';
import 'package:first_project/features/home/view_model/home_cubit.dart';
import 'package:first_project/features/home/view_model/home_states.dart';
import 'package:first_project/features/home/widget/home_slider_widget.dart';
import 'package:first_project/features/login/view/login_view.dart';
import 'package:first_project/features/product_details/view/product_details_view.dart';
import 'package:first_project/features/settings/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
part '../widget/home_categories_widget.dart';
part '../widget/empty_products_widget.dart';
part '../widget/home_drawer_widget.dart';
part '../widget/home_search_widget.dart';
part '../widget/home_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getCategory()),
        BlocProvider(create: (context) => CartIconCubit()..getcount()),
      ],
      child: AdvancedDrawer(
        controller: _advancedDrawerController,
        backdrop: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: const HomeDrawerWidget(),
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              child: CartIconView(onPressed: () {}),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Home',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                onPressed: () => _advancedDrawerController.showDrawer(),
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: Padding(
              padding: AppPadding.allpadding,
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(child: Text(''));
                  } else if (state is HomeErrorState) {
                    return Center(child: Text(state.error));
                  } else {
                    return RefreshIndicator(
                      color: Colors.white,
                      backgroundColor: AppColors.primary,
                      onRefresh: () async {
                        await context.read<HomeCubit>().getCategory();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            const _HomeSearchWidget(),
                            const SizedBox(height: 25),
                            _HomeCategoriesWidget(
                              categories: context.read<HomeCubit>().categoriesModel,
                            ),
                            const SizedBox(height: 25),
                            HomeSliderWidget(),
                            const SizedBox(height: 25),
                            if (state is! HomeLoadingState &&
                                state is! HomeLoadingProductsState &&
                                state is! HomeErrorState &&
                                state is! HomeErrorProductsState)
                              context.read<HomeCubit>().productModel.isEmpty
                                  ? const _EmptyProductsWidget()
                                  : const HomeGridView()
                            else
                              const Center(child: Text('')),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
