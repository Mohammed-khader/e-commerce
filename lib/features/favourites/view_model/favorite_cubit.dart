import 'package:first_project/features/favourites/repo/favourites_repo.dart';
import 'package:first_project/features/favourites/view_model/favorite_states.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());
  final _favoriteProduct = FavouritesRepo();
  List<ProductsModel> favoriteProduct = [];

  Future<void> getFavourites() async {
    emit(FavoriteLoadingState());
    final result = await _favoriteProduct.getFavourites();
    result.fold(
      (error) => emit(FavoriteErrorState(error: error)),
      (product) {
        favoriteProduct = product;
        return emit(FavoriteSuccessState());
      },
    );
  }

  Future<void> removeProductFromFavorite(ProductsModel product) async {
    favoriteProduct.remove(product);
    if (favoriteProduct.isEmpty) {
      emit(FavoriteUpdateState());
    }
    _favoriteProduct.removeProductFromFavorite(product.id);
  }
}
