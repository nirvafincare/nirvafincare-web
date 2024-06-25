import 'package:flutter/cupertino.dart';

extension NumUtils on num {
  num remap(num minExtent, num maxExtent, num minRange, num maxRange) {
    return (this - minExtent) /
            (maxExtent - minExtent) *
            (maxRange - minRange) +
        minRange;
  }

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());
}

extension ContextUtils on BuildContext {
  bool get isMobile => height > width;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;

// double get desktopXL => width/30;
//
// double get desktopXXL => width/25;
//
// double get desktopHeading => width/50;
//
// double get desktopSubHeading => width/60;
//
// double get desktopText => width/70;
}

extension LauncherUtils on String {
  Uri get mailTo => Uri(
        scheme: 'mailto',
        path: this,
        queryParameters: {'subject': '', 'body': ''},
      );
}
