import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatelessWidget {
  final List<String> imageUrls = [
    'https://www.shutterstock.com/image-vector/creative-banner-sneaker-brand-sneakers-260nw-2606078777.jpg',
    'https://i.pinimg.com/736x/ec/7e/34/ec7e34e77e7a557964754a0030bb83c0.jpg',
    'https://www.sliderrevolution.com/wp-content/uploads/2020/04/bigsummer_preview_new.jpg',
    'https://img.freepik.com/premium-vector/modern-sale-banner-website-slider-template-design_54925-45.jpg',
  ];

  HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
