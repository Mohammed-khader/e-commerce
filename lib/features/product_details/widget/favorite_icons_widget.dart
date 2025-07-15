part of '../view/product_details_view.dart';

class _FavoriteIconsWidget extends StatelessWidget {
  const _FavoriteIconsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
      buildWhen: (_, current) =>
          current is AddToFavoriteLoadingState ||
          current is AddToFavoriteErrorState ||
          current is AddToFavoriteSuccesState,
      builder: (context, state) {
        if (state is AddToFavoriteLoadingState) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          );
        }
        return context.read<ProductDetailsCubit>().isExisit
            ? GestureDetector(
                onTap: () {
                  context.read<ProductDetailsCubit>().removeProductFromFavorite();
                },
                child: const Icon(Icons.favorite, color: Colors.red),
              )
            : GestureDetector(
                onTap: () {
                  context.read<ProductDetailsCubit>().addProductToFavorite();
                },
                child: const Icon(Icons.favorite_border, color: Colors.black),
              );
      },
    );
  }
}
