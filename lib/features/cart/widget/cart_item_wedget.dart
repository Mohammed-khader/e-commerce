part of '../view/cart_view.dart';

class CartItemWedget extends StatelessWidget {
  const CartItemWedget({super.key, required this.product, required this.index});
  final ProductsModel product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 5,
          child: Container(
            height: 120,
            color: Colors.white,
            child: Row(
              children: [
                _getProductImage(),
                _getProductInfo(),
                const Spacer(),
                _CounterWidget(index: index, productID: product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProductImage() {
    return Image.network(width: 120, product.image);
  }

  Widget _getProductInfo() {
    return SizedBox(
      width: 130,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Text(product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 10)),
              const Spacer(),
              Text(
                '${product.price} \$',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
