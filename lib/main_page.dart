import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constant/numbers.dart';
import 'core/component/widgets/message_display.dart';
import 'core/component/widgets/trivia_drawer.dart';
import 'features/date_trivia/presentation/pages/date_trivia_page.dart';
import 'features/math_trivia/presentation/pages/math_trivia_page.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'features/year_trivia/presentation/pages/year_trivia_page.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

int indexPage = 0;

class _MainPageState extends State<MainPage> {
  List<Widget> triviaPages = [
    NumberTriviaPage(),
    YearTriviaPage(),
    NumberTriviaPage(),
    YearTriviaPage()
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Curious Digit',
          style: GoogleFonts.fredokaOne(fontSize: smallText),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: TriviaDrawer(
          selectedIndex: indexPage,
          onTap: (int index) {
            indexPage = index;
            setState(() {});
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Builder(
          builder: (context) {
            switch (indexPage) {
              case 0:
                return NumberTriviaPage();
                break;
              case 1:
                return YearTriviaPage();
              case 2:
                return DateTriviaPage();
                break;
              case 3:
                return MathTriviaPage();
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}
