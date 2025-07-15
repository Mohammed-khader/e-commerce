abstract class ProductDetailsStates {}

class AddToCartInitialState extends ProductDetailsStates {}

class AddToCartLoadingState extends ProductDetailsStates {}

class AddToCartErrorState extends ProductDetailsStates {
  final String error;

  AddToCartErrorState({required this.error});
}

class AddToCartSuccesState extends ProductDetailsStates {}

class AddToFavoriteLoadingState extends ProductDetailsStates {}

class AddToFavoriteErrorState extends ProductDetailsStates {
  final String error;

  AddToFavoriteErrorState({required this.error});
}

class AddToFavoriteSuccesState extends ProductDetailsStates {}
