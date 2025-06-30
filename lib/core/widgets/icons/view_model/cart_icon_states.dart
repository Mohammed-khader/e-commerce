abstract class CartIconStates {}

class CartIconInitialState extends CartIconStates {}

class CartIconLoadingState extends CartIconStates {}

class CartIconErrorState extends CartIconStates {
  final String error;

  CartIconErrorState({required this.error});
}

class CartIconSuccessState extends CartIconStates {
  final int count;

  CartIconSuccessState({required this.count});
}
