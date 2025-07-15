part of '../view/product_details_view.dart';

class _ProductInfoWidget extends StatelessWidget {
  const _ProductInfoWidget({required this.productDetails});
  final ProductsModel productDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Card(child: Image.network(productDetails.image, width: 250)),
        ),
        const SizedBox(height: 10),
        Text(
          productDetails.name,
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '${productDetails.price} \$',
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.green),
        ),
        const SizedBox(height: 10),
        Text(
          productDetails.description,
          style: GoogleFonts.poppins(fontSize: 15),
          maxLines: 2,
        ),
        const SizedBox(height: 25),
        CustomButtons(
          text: 'Add To Cart',
          onTap: () {
            context.read<ProductDetailsCubit>().addToCart(context);
          },
        )
      ],
    );
  }
}
