import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../../domain/entities/math_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    Key key,
    @required this.size,
    @required this.trivia,
  }) : super(key: key);

  final Size size;
  final MathTrivia trivia;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .3,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${trivia.number}',
            style:
                GoogleFonts.fredokaOne(color: colorPrimary, fontSize: bigText),
          ),
          Text(
            '${trivia.text}',
            style: GoogleFonts.nunito(fontSize: smallText),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
