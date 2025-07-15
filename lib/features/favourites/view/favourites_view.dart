import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/features/favourites/view_model/favorite_cubit.dart';
import 'package:first_project/features/favourites/view_model/favorite_states.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/product_details/view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavourites(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favourites',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<FavoriteCubit, FavoriteStates>(
          builder: (context, state) {
            final favourites = context.read<FavoriteCubit>().favoriteProduct;
            if (state is FavoriteLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is FavoriteErrorState) {
              return Center(child: Text(state.error));
            } else if (state is FavoriteSuccessState || state is FavoriteUpdateState) {
              if (favourites.isEmpty) {
                return Center(
                  child: Text(
                    'No Favourites Products Added',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                );
              }

              return ListView.builder(
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final product = favourites[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CartIconCubit>(),
                            child: ProductDetailsView(productDetails: product),
                          ),
                        ),
                      );
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context.read<FavoriteCubit>().removeProductFromFavorite(product);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        elevation: 4,
                        child: getfavoritInfo(product),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget getfavoritInfo(ProductsModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
            product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.price}\$',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
