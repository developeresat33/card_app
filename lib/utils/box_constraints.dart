import 'package:card_application/utils/colors.dart';
import 'package:flutter/material.dart';

Decoration boxDecorationWithShadow({
  Color backgroundColor = Colors.white,
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
  LinearGradient gradient,
  BoxBorder border,
  List<BoxShadow> boxShadow,
  DecorationImage decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
  BorderRadius borderRadius,
}) {
  return BoxDecoration(
    boxShadow: boxShadow ??
        defaultBoxShadow(
          shadowColor: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
    color: backgroundColor,
    gradient: gradient,
    border: border,
    image: decorationImage,
    shape: boxShape,
    borderRadius: borderRadius,
  );
}

Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
double defaultBlurRadius = 4.0;
double defaultSpreadRadius = 1.0;
double defaultRadius = 8.0;
List<BoxShadow> defaultBoxShadow({
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}

Decoration boxDecorationRoundedWithShadow(
  int radiusAll, {
  Color backgroundColor = Colors.white,
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
  LinearGradient gradient,
}) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    ),
    color: backgroundColor,
    gradient: gradient,
    borderRadius: radius(radiusAll.toDouble()),
  );
}

BorderRadius radius([double radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

Radius radiusCircular([double radius]) {
  return Radius.circular(radius ?? defaultRadius);
}

Decoration boxDecorationWithRoundedCorners({
  Color backgroundColor = Colors.white,
  BorderRadius borderRadius,
  LinearGradient gradient,
  BoxBorder border,
  List<BoxShadow> boxShadow,
  DecorationImage decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius:
        boxShape == BoxShape.circle ? null : (borderRadius ?? radius()),
    gradient: gradient,
    border: border,
    boxShadow: boxShadow,
    image: decorationImage,
    shape: boxShape,
  );
}

InputDecoration waInputDecoration(
    {IconData prefixIcon,
    String hint,
    Color bgColor,
    Color borderColor,
    EdgeInsets padding}) {
  return InputDecoration(
    contentPadding:
        padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: Offstage(),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? WAPrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? WAPrimaryColor.withOpacity(0.04),
    hintText: hint,
    filled: true,
  );
}
