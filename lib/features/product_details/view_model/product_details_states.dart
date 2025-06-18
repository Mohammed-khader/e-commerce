abstract class ProductDetailsStates {}

class AddToCartInitialState extends ProductDetailsStates {}

class AddToCartLoadingState extends ProductDetailsStates {}

class AddToCartErrorState extends ProductDetailsStates {
  final String error;

  AddToCartErrorState({required this.error});
}

class AddToCartSuccesState extends ProductDetailsStates {}
