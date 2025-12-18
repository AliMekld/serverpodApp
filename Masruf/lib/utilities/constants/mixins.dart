import 'package:flutter/material.dart';

mixin ResponsiveStatfullMixin<T extends StatefulWidget> on State<T> {
  Widget responsiveBuild(
     {
    required Widget largeScreen,
    required Widget mediumScreen,
    required Widget smallScreen,
  }) {

    return LayoutBuilder(builder: (context, constaints) {
      if (constaints.maxWidth< 600) {
        return smallScreen;
      } else if (constaints.maxWidth >= 600 && constaints.maxWidth < 1024) {
        return mediumScreen;
      } else {
        return largeScreen;
      }
    });
  }
}
mixin ResponsiveStatelessMixin<T extends StatelessWidget>  {
  Widget responsiveBuild({
    required Widget largeScreen,
    required Widget mediumScreen,
    required Widget smallScreen,
  }) {
    return LayoutBuilder(builder: (context, constaints) {
      if (constaints.maxWidth >= 1024) {
        return largeScreen;
      } else if (constaints.maxWidth >= 600) {
        return mediumScreen;
      } else {
        return smallScreen;
      }
    });
  }
}
