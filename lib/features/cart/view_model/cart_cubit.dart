import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/features/cart/repo/cart_repo.dart';
import 'package:first_project/features/cart/view_model/cart_states.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());
  final _cartRepo = CartRepo();

  List<ProductsModel> cartProduct = [];
  double totalPrice = 0;
  Future<void> getCartItems() async {
    emit(CartLoadingState());
    final result = await _cartRepo.getCartItems();
    result.fold(
      (error) => emit(CartErrorState(error: error)),
      (products) {
        cartProduct = products;
        calculateTotal();
        emit(CartSuccessState());
      },
    );
  }

  Future<void> updateCount(int index) async {
    final count = cartProduct[index].count;
    final productId = cartProduct[index].id;
    _cartRepo.updateCount((count ?? 1), productId);
  }

  addCount(int index) {
    cartProduct[index].count = (cartProduct[index].count ?? 1) + 1;
    calculateTotal();
    updateCount(index);

    emit(CartUpdateCountState());
  }

  removeCount(int index) {
    cartProduct[index].count = (cartProduct[index].count ?? 1) - 1;
    calculateTotal();
    updateCount(index);

    emit(CartUpdateCountState());
  }

  void removeProducts(String productID, BuildContext context) async {
    final cubit = context.read<CartIconCubit>();
    cartProduct.removeWhere((product) => product.id == productID);
    calculateTotal();
    emit(CartUpdateProductsState());
    final result = await _cartRepo.removeProducts(productID);
    result.fold(
      (erorr) => CartErrorState(error: erorr),
      (_) {
        cubit.getcount();
      },
    );
  }

  void calculateTotal() {
    double total = 0.0;
    for (var element in cartProduct) {
      total += element.price * (element.count ?? 1);
    }
    totalPrice = double.tryParse(total.toStringAsFixed(2)) ?? 0;
  }
}
