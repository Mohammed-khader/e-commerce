import 'package:first_project/features/home/model/category_model.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/home/repo/home_repo.dart';
import 'package:first_project/features/home/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  final HomeRepo homeRepo = HomeRepo();

  List<CategoryModel> categoriesModel = [];
  List<ProductsModel> productModel = [];

  int selectedIndex = 0;

  Future<void> getCategory() async {
    emit(HomeLoadingState());

    final result = await homeRepo.getCategory();
    result.fold(
      (error) => emit(HomeErrorState(error: error)),
      (categories) async {
        categoriesModel = categories;
        emit(HomeSuccessState());

        if (categoriesModel.isNotEmpty) {
          selectedIndex = 0;
          await getProductsByCategoryID(categoriesModel[0].id ?? '');
        }
      },
    );
  }

  Future<void> changeSelectedIndex(int index) async {
    selectedIndex = index;
    emit(HomeUpadateCategoryIndexState());

    await getProductsByCategoryID(categoriesModel[selectedIndex].id ?? '');
  }

  Future<void> getProductsByCategoryID(String categoryId) async {
    emit(HomeLoadingProductsState());

    final result = await homeRepo.getProductsByCategoryID(categoryId);
    result.fold(
      (error) => emit(HomeErrorState(error: error)),
      (products) {
        productModel = products;
        emit(HomeSuccessState());
      },
    );
  }
}
