import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextType { defaultStyle, inter, sans }

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

class CustomTextIBM extends StatelessWidget {
  const CustomTextIBM({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.ibmPlexSerif(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
