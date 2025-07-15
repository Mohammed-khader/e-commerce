part of '../view/home_view.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) => current is HomeSearchState,
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
          ),
          itemCount: context.read<HomeCubit>().searchController.text.isEmpty
              ? context.read<HomeCubit>().productModel.length
              : context.read<HomeCubit>().searchProduct.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CartIconCubit>(),
                        child: ProductDetailsView(
                          productDetails:
                              context.read<HomeCubit>().searchController.text.isEmpty
                                  ? context.read<HomeCubit>().productModel[index]
                                  : context.read<HomeCubit>().searchProduct[index],
                        ),
                      ),
                    ),
                  );
                },
                child: _getItemWidget(
                    context.read<HomeCubit>().searchController.text.isEmpty
                        ? context.read<HomeCubit>().productModel[index]
                        : context.read<HomeCubit>().searchProduct[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _getItemWidget(product) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.image,
              height: 125,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(product.name, style: GoogleFonts.poppins()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text('${product.price.toString()} \$', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
