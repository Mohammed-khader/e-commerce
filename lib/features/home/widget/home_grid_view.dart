import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      'https://media.wired.com/photos/599dcfe8d6c80105bd749ea7/3:2/w_1920,c_limit/joker-TA.jpg',
                    ),
                  ),
                  Text(
                    'Product Name :',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'price :',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
