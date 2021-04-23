import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/component/widgets/carousel_slider_display.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../../../../core/component/widgets/loading_display.dart';
import '../../../../core/component/widgets/message_display.dart';
import '../../../../injection_container.dart';

import '../widgets/widgets.dart';

import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatefulWidget {
  @override
  _NumberTriviaPageState createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => trivia<NumberTriviaBloc>(),
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                      size: size, text: 'Start Number Trivia!');
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
