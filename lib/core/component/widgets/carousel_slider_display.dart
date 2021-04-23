import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/carousel_item.dart';

class CarouselSliderDisplay extends StatelessWidget {
  const CarouselSliderDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
          initialPage: Random().nextInt(carouselItems.length - 1),
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.easeOutQuad,
          scrollDirection: Axis.horizontal,
        ),
        items: carouselItems.map((item) {
          return Container(
              child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${item.headLine}',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${item.description}',
                style: GoogleFonts.nunito(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          )));
        }).toList());
  }
}
