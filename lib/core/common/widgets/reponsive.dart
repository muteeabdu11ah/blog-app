import 'package:flutter/material.dart';

class ResponsiveHeight {
  final BuildContext context;
  double height;

  ResponsiveHeight({
    required this.context,
  }) : height = MediaQuery.of(context).size.height;

  double scale(double factor) {
    return height * (factor / 100);
  }
}

class ResponsiveWidth {
  final BuildContext context;
  double width;

  ResponsiveWidth({
    required this.context,
  }) : width = MediaQuery.of(context).size.width;

  double scale(double factor) {
    return width * (factor) / 100;
  }
}
