import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * .3,
        width: size.width,
        child: Center(
          child: Lottie.asset('assets/loading.json'),
        ));
  }
}
