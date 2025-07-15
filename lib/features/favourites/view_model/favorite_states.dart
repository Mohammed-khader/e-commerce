abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteLoadingState extends FavoriteStates {}

class FavoriteErrorState extends FavoriteStates {
  final String error;

  FavoriteErrorState({required this.error});
}

class FavoriteSuccessState extends FavoriteStates {}

class FavoriteUpdateState extends FavoriteStates {}
