import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/util/outline_text.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/numbers.dart';
import '../bloc/date_trivia_bloc.dart';

class TriviaControl extends StatefulWidget {
  @override
  _TriviaControlState createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  String day, month;
  List listOfDays = [for (var i = 1; i <= 31; i += 1) '$i'];
  List listOfMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    void dispatchRandom() {
      setState(() {});
      BlocProvider.of<DateTriviaBloc>(context).add(GetTriviaForRandomDate());
    }

    void dispatchConcrete({@required String day, @required String month}) {
      BlocProvider.of<DateTriviaBloc>(context)
          .add(GetTriviaForConcreteDate(strDay: day, strMonth: month));
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorPrimary)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                  underline: SizedBox(),
                  icon: FaIcon(
                    FontAwesomeIcons.calendar,
                    color: colorPrimary,
                  ),
                  dropdownColor: colorPrimary,
                  hint: Text(
                    "Month",
                    style: GoogleFonts.nunito(
                      fontSize: smallText,
                    ),
                  ),
                  value: month,
                  onChanged: (value) {
                    setState(() {
                      month = value;
                    });
                  },
                  items: listOfMonths
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.nunito(fontSize: smallText),
                            ),
                          ))
                      .toList()),
              DropdownButton<String>(
                  underline: SizedBox(),
                  icon: FaIcon(
                    FontAwesomeIcons.calendarDay,
                    color: colorPrimary,
                  ),
                  dropdownColor: colorPrimary,
                  hint: Text(
                    "Day",
                    style: GoogleFonts.nunito(
                      fontSize: smallText,
                    ),
                  ),
                  value: day,
                  onChanged: (value) {
                    setState(() {
                      day = value;
                    });
                  },
                  items: listOfDays
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.nunito(fontSize: smallText),
                            ),
                          ))
                      .toList()),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              onPressed: () => dispatchConcrete(
                day: day,
                month: month,
              ),
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
