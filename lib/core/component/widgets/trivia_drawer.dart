import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';
import '../../constant/strings.dart';
import '../../constant/numbers.dart';
import 'package:url_launcher/url_launcher.dart';

class TriviaDrawer extends StatelessWidget {
  final Function onTap;
  final int selectedIndex;
  const TriviaDrawer(
      {Key key, @required this.onTap, @required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            DrawerHeader(
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/ic_launcher.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  ListTileDisplay(
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                    index: 0,
                    text: 'Number Trivia',
                  ),
                  // Divider(
                  //   color: colorPrimary,
                  //   indent: 10,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTileDisplay(
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                    index: 1,
                    text: 'Year Trivia',
                  ),
                  // Divider(
                  //   color: colorPrimary,
                  //   indent: 10,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTileDisplay(
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                    index: 2,
                    text: 'Date Trivia',
                  ),
                  // Divider(
                  //   color: colorPrimary,
                  //   indent: 10,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTileDisplay(
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                    index: 3,
                    text: 'Math Trivia',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Visit Github',
                          style: GoogleFonts.nunito(
                              fontSize: smallText,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () async {
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url';
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.copyright,
              color: Colors.grey,
              size: 10,
            ),
            SizedBox(
              width: 5,
            ),
            CopyRight(
              text: 'Jan-Jan Tech',
            ),
            CopyRight(
              text: '  |  ',
            ),
            CopyRight(
              text: 'Karl Jan Reginaldo',
            ),
          ],
        )
      ],
    );
  }
}

class CopyRight extends StatelessWidget {
  const CopyRight({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: 10,
        color: Colors.grey,
      ),
    );
  }
}

class ListTileDisplay extends StatelessWidget {
  const ListTileDisplay(
      {Key key,
      @required this.selectedIndex,
      @required this.onTap,
      @required this.index,
      @required this.text})
      : super(key: key);
  final int selectedIndex;
  final Function onTap;
  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        color:
            selectedIndex == index ? colorPrimary : Colors.white.withOpacity(0),
      ),
      selected: selectedIndex == index,
      selectedTileColor: Colors.grey.withOpacity(0.2),
      title: Text(
        text,
        style: GoogleFonts.nunito(
            fontSize: smallText, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        onTap(index);
        Navigator.of(context).pop();
      },
    );
  }
}
