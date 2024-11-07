import 'package:flutter/material.dart';

abstract class Styles {
  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w400,
      fontFamily: 'DM Sans',
      color: const Color(0xffBABABA),
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w500,
      fontFamily: 'DM Sans',
      color: const Color(0xff00060D),
    );
  }

  static TextStyle styleMedium12(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w500,
      fontFamily: 'DM Sans',
      color: const Color(0xffFF7D53),
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
        fontSize: getResoponsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w400,
        fontFamily: 'DM Sans',
        color: const Color(0xff24252c99));
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: const Color(0xff24252C),
    );
  }

  static TextStyle styleBold18(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: const Color(0xff2f2f2f99),
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: const Color(0xff24252C),
    );
  }

  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
        fontSize: getResoponsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w400,
        fontFamily: 'DM Sans',
        color: const Color(0xff7C7C80));
  }

  static TextStyle styleBold19(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 19),
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: const Color(0xffFFFFFF),
    );
  }

  static TextStyle styleBold14(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: const Color(0xff7F7F7F),
    );
  }

  static TextStyle styleMedium14(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w500,
      fontFamily: 'DM Sans',
      color: const Color(0xff2F2F2F),
    );
  }

  static TextStyle styleRegular9(BuildContext context) {
    return TextStyle(
        fontSize: getResoponsiveFontSize(context, fontSize: 9),
        fontWeight: FontWeight.w400,
        fontFamily: 'DM Sans',
        color: const Color(0xff6E6A7C));
  }

  static TextStyle styleMedium19(BuildContext context) {
    return TextStyle(
      fontSize: getResoponsiveFontSize(context, fontSize: 19),
      fontWeight: FontWeight.w500,
      fontFamily: 'DM Sans',
      color: const Color(0xff5F33E1),
    );
  }
}

double getResoponsiveFontSize(BuildContext context,
    {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFotSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFotSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;

  return width / 400;
}
