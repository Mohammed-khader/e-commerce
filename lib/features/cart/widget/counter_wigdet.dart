part of '../view/cart_view.dart';

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({required this.index, required this.productID});
  final String productID;
  final int index;

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CloseButton(onPressed: () {
            context.read<CartCubit>().removeProducts(widget.productID, context);
          }),
          const Spacer(),
          Row(
            children: [
              InkWell(
                radius: 50,
                onTap: () {
                  context.read<CartCubit>().addCount(widget.index);
                },
                child: const Icon(
                  Icons.add,
                  size: 16,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                context.read<CartCubit>().cartProduct[widget.index].count.toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                radius: 50,
                onTap: () {
                  context.read<CartCubit>().removeCount(widget.index);
                },
                child: const Icon(
                  Icons.remove,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
