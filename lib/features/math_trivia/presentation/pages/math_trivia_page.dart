import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/component/widgets/carousel_slider_display.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../widgets/widgets.dart';
import '../../../../core/component/widgets/loading_display.dart';
import '../../../../core/component/widgets/message_display.dart';
import '../../../../injection_container.dart';

import '../bloc/math_trivia_bloc.dart';

class MathTriviaPage extends StatefulWidget {
  @override
  _MathTriviaPageState createState() => _MathTriviaPageState();
}

class _MathTriviaPageState extends State<MathTriviaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => trivia<MathTriviaBloc>(),
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<MathTriviaBloc, MathTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(size: size, text: 'Start Math Trivia!');
                } else if (state is Loading) {
                  return LoadingDisplay(size: size);
                } else if (state is Loaded) {
                  return TriviaDisplay(
                    size: size,
                    trivia: state.trivia,
                  );
                } else if (state is Error) {
                  return MessageDisplay(size: size, text: state.message);
                }
                return MessageDisplay(
                    size: size, text: 'Please Restart Your Device');
              },
            ),
            TriviaControl(),
            SizedBox(
              height: 60,
            ),
            Text(
              'Did you know?',
              style: GoogleFonts.nunito(
                  fontSize: semiMediumText,
                  color: colorPrimary,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: CarouselSliderDisplay())
          ],
        ),
      ),
    );
  }
}
