import 'package:flutter/material.dart';

mixin ResponsiveStatufullBuilder<T extends StatefulBuilder> on State {
  Widget buildMobile(BuildContext context);
  Widget buildTablet(BuildContext context);
  Widget buildDesktop(BuildContext context);
  Widget responsiveLatout({
    required Widget mobile,
    required Widget tablet,
    required Widget desktop,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else if (constraints.maxWidth < 1200) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return responsiveLatout(
      mobile: buildMobile(context),
      tablet: buildTablet(context),
      desktop: buildDesktop(context),
    );
  }
}
mixin ResponsiveStatelessBuilder<T extends StatelessWidget>
    on StatelessWidget {}
