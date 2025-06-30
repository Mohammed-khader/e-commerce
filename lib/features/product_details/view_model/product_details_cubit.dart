import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/product_details/repo/product_details_repo.dart';
import 'package:first_project/features/product_details/view_model/product_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit({required this.product}) : super(AddToCartInitialState());
  final ProductsModel product;
  final ProductDetailsRepo productDetailsRepo = ProductDetailsRepo();
  Future<void> addToCart(BuildContext context) async {
    emit(AddToCartLoadingState());
    final result = await productDetailsRepo.addToCart(productDetails: product);
    result.fold(
      (error) => emit(AddToCartErrorState(error: error)),
      (_) => upDataCartCount(context),
    );
  }

  Future<void> upDataCartCount(BuildContext context) async {
    if (context.mounted) {
      await context.read<CartIconCubit>().getcount();
      emit(AddToCartSuccesState());
    }
  }
}
