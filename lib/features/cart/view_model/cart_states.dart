abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartErrorState extends CartStates {
  final String error;

  CartErrorState({required this.error});
}

class CartSuccessState extends CartStates {}

class CartUpdateCountState extends CartStates {}

class CartUpdateProductsState extends CartStates {}
