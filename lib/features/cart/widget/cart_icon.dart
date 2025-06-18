import 'package:flutter/material.dart';

class CartIconButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CartIconButton({super.key, required this.itemCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.black),
            onPressed: onPressed,
          ),
          if (itemCount > 0)
            Positioned(
              right: 0,
              top: -5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Text(
                  itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
