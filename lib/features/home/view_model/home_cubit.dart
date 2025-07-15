import 'package:first_project/features/home/model/category_model.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/home/repo/home_repo.dart';
import 'package:first_project/features/home/view_model/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  final HomeRepo homeRepo = HomeRepo();
  final searchController = TextEditingController();
  List<CategoryModel> categoriesModel = [];
  List<ProductsModel> productModel = [];
  List<ProductsModel> searchProduct = [];

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

  void getSearchProduct(String name) {
    searchProduct.clear();
    for (var element in productModel) {
      if (element.name.toLowerCase().contains(name.toLowerCase())) {
        searchProduct.add(element);
      }
    }
    emit(HomeSearchState());
  }
}
