import 'package:flutter/material.dart';

class MakeResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  MakeResponsive(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxHeight >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
