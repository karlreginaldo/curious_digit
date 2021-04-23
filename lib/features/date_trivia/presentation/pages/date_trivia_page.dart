import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/date_trivia_bloc.dart';
import '../../../../core/component/widgets/carousel_slider_display.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../../../../core/component/widgets/loading_display.dart';
import '../../../../core/component/widgets/message_display.dart';
import '../../../../injection_container.dart';

import '../widgets/widgets.dart';

class DateTriviaPage extends StatefulWidget {
  @override
  _DateTriviaPageState createState() => _DateTriviaPageState();
}

class _DateTriviaPageState extends State<DateTriviaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => trivia<DateTriviaBloc>(),
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<DateTriviaBloc, DateTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  print('Empty');
                  return MessageDisplay(
                      size: size, text: 'Start Number Trivia!');
                } else if (state is Loading) {
                  print('Loading');

                  return LoadingDisplay(size: size);
                } else if (state is Loaded) {
                  print('Loaded');

                  return TriviaDisplay(
                    size: size,
                    trivia: state.trivia,
                  );
                } else if (state is Error) {
                  print('Error');

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
