import 'package:first_project/features/home/view_model/home_cubit.dart';
import 'package:first_project/features/product_details/view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemCount: context.read<HomeCubit>().productModel.length,
        itemBuilder: (context, index) {
          final product = context.read<HomeCubit>().productModel[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ProductDetailsView(productDetails: product);
                }));
              },
              child: Card(
                color: Colors.white,
                child: SingleChildScrollView(
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
