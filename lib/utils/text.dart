// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ModifiedText extends StatelessWidget {
  final String text;
  double size;
  Color color;

  ModifiedText({
    Key? key,
    required this.text,
    this.size = 10,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.breeSerif(
          fontSize: size,
          color: color,
        ));
  }
}
