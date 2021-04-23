import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';
import '../../constant/numbers.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({Key key, @required this.size, @required this.text})
      : super(key: key);

  final Size size;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .3,
      width: size.width,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.fredokaOne(color: colorPrimary, fontSize: bigText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
