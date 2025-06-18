import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/product_details/repo/product_details_repo.dart';
import 'package:first_project/features/product_details/view_model/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit({required this.product}) : super(AddToCartInitialState());
  final ProductsModel product;
  final ProductDetailsRepo productDetailsRepo = ProductDetailsRepo();
  Future<void> addToCart() async {
    emit(AddToCartLoadingState());
    final result = await productDetailsRepo.addToCart(productDetails: product);
    result.fold(
      (error) => emit(AddToCartErrorState(error: error)),
      (_) => emit(AddToCartSuccesState()),
    );
  }
}
