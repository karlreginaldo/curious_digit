import 'package:flutter/material.dart';
import 'core/constant/colors.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

import 'features/year_trivia/presentation/pages/year_trivia_page.dart';
import 'main_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/number_trivia': (context) => NumberTriviaPage(),
        '/year_trivia': (context) => YearTriviaPage(),
        '/date_trivia': (context) => MainPage(),
        '/math_trivia': (context) => MainPage(),
      },
    );
  }
}
