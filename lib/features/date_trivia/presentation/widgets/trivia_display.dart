import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/date_trivia.dart';
import '../../../number_trivia/domain/entities/number_trivia.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    Key key,
    @required this.size,
    @required this.trivia,
  }) : super(key: key);

  final Size size;
  final DateTrivia trivia;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .3,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${trivia.text.split(' ').first}',
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
