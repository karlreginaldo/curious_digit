import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/util/outline_text.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../bloc/number_trivia_bloc.dart';

class TriviaControl extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void dispatchRandom() {
      BlocProvider.of<NumberTriviaBloc>(context)
          .add(GetTriviaForRandomNumber());
    }

    void dispatchConcrete(String text) {
      controller.clear();
      BlocProvider.of<NumberTriviaBloc>(context)
          .add(GetTriviaForConcreteNumber(text));
    }

    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorPrimary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorPrimary)),
            prefixIcon:
                Lottie.asset('assets/search.json', width: 20, height: 20),
          ),
          onSubmitted: dispatchConcrete,
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              onPressed: () => dispatchConcrete(controller.text),
              child: Text(
                'SEARCH',
                style: GoogleFonts.fredokaOne(
                    color: Colors.white,
                    fontSize: semiMediumText,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: colorPrimary,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              onPressed: dispatchRandom,
              child: Text(
                'RANDOM',
                style: GoogleFonts.fredokaOne(
                    color: Colors.white,
                    fontSize: semiMediumText,
                    fontWeight: FontWeight.bold,
                    shadows: outlinedText(
                        strokeColor: colorPrimary, strokeWidth: 1)),
                textAlign: TextAlign.center,
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: colorPrimary, width: 1)),
            ),
          ],
        )
      ],
    );
  }
}
